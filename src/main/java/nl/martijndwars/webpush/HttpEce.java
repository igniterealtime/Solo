package nl.martijndwars.webpush;

import org.bouncycastle.crypto.digests.SHA256Digest;
import org.bouncycastle.crypto.generators.HKDFBytesGenerator;
import org.bouncycastle.crypto.params.HKDFParameters;
import org.bouncycastle.jce.interfaces.ECPublicKey;

import javax.crypto.*;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.security.*;
import java.util.Map;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * An implementation of HTTP ECE (Encrypted Content Encoding) as described in
 * https://tools.ietf.org/html/draft-ietf-httpbis-encryption-encoding-01
 */
public class HttpEce {
    private Map<String, KeyPair> keys;
    private Map<String, String> labels;

    public HttpEce(Map<String, KeyPair> keys, Map<String, String> labels) {
        this.keys = keys;
        this.labels = labels;
    }

    /**
     * Future versions might require a null-terminated info string?
     *
     * @param type
     * @return
     */
    protected static byte[] buildInfo(String type, byte[] context) {
        ByteBuffer buffer = ByteBuffer.allocate(19 + type.length() + context.length);

        buffer.put("Content-Encoding: ".getBytes(UTF_8), 0, 18);
        buffer.put(type.getBytes(UTF_8), 0, type.length());
        buffer.put(new byte[1], 0, 1);
        buffer.put(context, 0, context.length);

        return buffer.array();
    }

    /**
     * Convenience method for computing the HMAC Key Derivation Function. The
     * real work is offloaded to BouncyCastle.
     */
    protected static byte[] hkdfExpand(byte[] ikm, byte[] salt, byte[] info, int length) throws InvalidKeyException, NoSuchAlgorithmException {
        HKDFBytesGenerator hkdf = new HKDFBytesGenerator(new SHA256Digest());
        hkdf.init(new HKDFParameters(ikm, salt, info));

        byte[] okm = new byte[length];
        hkdf.generateBytes(okm, 0, length);

        return okm;
    }

    public byte[][] deriveKey(byte[] salt, byte[] key, String keyId, PublicKey dh, byte[] authSecret, int padSize) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, InvalidAlgorithmParameterException, BadPaddingException, IllegalBlockSizeException, NoSuchProviderException, IOException {
        byte[] secret = null;
        byte[] context = null;

        if (key != null) {
            secret = key;
        } else if (dh != null) {
            byte[][] bytes = deriveDH(keyId, dh);
            secret = bytes[0];
            context = bytes[1];
        } else if (keyId != null) {
            secret = keys.get(keyId).getPublic().getEncoded();
        }

        if (secret == null) {
            throw new IllegalStateException("Unable to determine the secret");
        }

        byte[] keyinfo;
        byte[] nonceinfo;

        if (authSecret != null) {
            secret = hkdfExpand(secret, authSecret, buildInfo("auth", new byte[0]), 32);
        }

        keyinfo = buildInfo("aesgcm", context);
        nonceinfo = buildInfo("nonce", context);

        byte[] hkdf_key = hkdfExpand(secret, salt, keyinfo, 16);
        byte[] hkdf_nonce = hkdfExpand(secret, salt, nonceinfo, 12);

        return new byte[][]{
                hkdf_key,
                hkdf_nonce
        };
    }

    /**
     * Compute the shared secret using the server's key pair (indicated by
     * keyId) and the client's public key. Also compute context.
     *
     * @param keyId
     * @param publicKey
     * @return
     */
    private byte[][] deriveDH(String keyId, PublicKey publicKey) throws NoSuchProviderException, NoSuchAlgorithmException, InvalidKeyException, IOException {
        PublicKey senderPubKey = keys.get(keyId).getPublic();

        KeyAgreement keyAgreement = KeyAgreement.getInstance("ECDH");
        keyAgreement.init(keys.get(keyId).getPrivate());
        keyAgreement.doPhase(publicKey, true);

        byte[] secret = keyAgreement.generateSecret();
        byte[] context = concat(labels.get(keyId).getBytes(UTF_8), new byte[1], lengthPrefix(publicKey), lengthPrefix(senderPubKey));

        return new byte[][]{
                secret,
                context
        };
    }

    private byte[] lengthPrefix(Key key) throws IOException {
        byte[] bytes = Utils.savePublicKey((ECPublicKey) key);

        return concat(intToBytes(bytes.length), bytes);
    }

    /**
     * Cast an integer to a two-byte array
     */
    private byte[] intToBytes(int x) throws IOException {
        byte[] bytes = new byte[2];

        bytes[1] = (byte) (x & 0xff);
        bytes[0] = (byte) (x >> 8);

        return bytes;
    }

    /**
     * Utility to concat byte arrays
     */
    private byte[] concat(byte[]... arrays) {
        int lastPos = 0;

        byte[] combined = new byte[combinedLength(arrays)];

        for (byte[] array : arrays) {
            System.arraycopy(array, 0, combined, lastPos, array.length);

            lastPos += array.length;
        }

        return combined;
    }

    /**
     * Compute combined array length
     */
    private int combinedLength(byte[]... arrays) {
        int combinedLength = 0;

        for (byte[] array : arrays) {
            combinedLength += array.length;
        }

        return combinedLength;
    }

    public byte[] encrypt(byte[] buffer, byte[] salt, byte[] key, String keyid, PublicKey dh, byte[] authSecret, int padSize) throws NoSuchPaddingException, InvalidAlgorithmParameterException, NoSuchAlgorithmException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException, NoSuchProviderException, IOException {
        byte[][] derivedKey = deriveKey(salt, key, keyid, dh, authSecret, padSize);
        byte[] key_ = derivedKey[0];
        byte[] nonce_ = derivedKey[1];

        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding", "BC");
        cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(key_, "AES"), new GCMParameterSpec(16 * 8, nonce_));
        cipher.update(new byte[padSize]);

        return cipher.doFinal(buffer);
    }
}
