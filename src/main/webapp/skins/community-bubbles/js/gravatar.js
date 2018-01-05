function getIcon(email){
    return "http://secure.gravatar.com/avatar/" + hex_md5(trim(email.toLowerCase())) +"?s=160&r=G";
}

function trim(str){  
	return str.replace(/(^\s*)|(\s*$)/g, "");  
}
