parse_yaml() {
   _parse_yaml_keys=$2
   _parse_yaml_keys_delimiter="${3:-"|"}"
   _parse_yaml_s='[[:space:]]*' _parse_yaml_w='[a-zA-Z0-9_]*' _parse_yaml_fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($_parse_yaml_s\):|\1|" \
        -e "s|^\($_parse_yaml_s\)\($_parse_yaml_w\)$_parse_yaml_s:$_parse_yaml_s[\"']\(.*\)[\"']$_parse_yaml_s\$|\1$_parse_yaml_fs\2$_parse_yaml_fs\3|p" \
        -e "s|^\($_parse_yaml_s\)\($_parse_yaml_w\)$_parse_yaml_s:$_parse_yaml_s\(.*\)$_parse_yaml_s\$|\1$_parse_yaml_fs\2$_parse_yaml_fs\3|p"  "$1" |
   awk -F"$_parse_yaml_fs" '{
      received_keys = "'$_parse_yaml_keys'"
      split(received_keys, yaml_check_key, "'$_parse_yaml_keys_delimiter'")
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
        vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
        gsub(/\#(.*)+$/, "", $3); gsub(/^[ \t]+/, "", $3); gsub(/[ \t]+$/, "", $3); 
        for (i in yaml_check_key) {if (yaml_check_key[i] == $2) {printf("%s=\"%s\"\n",  $2, $3);}}
      }
   }'
}
