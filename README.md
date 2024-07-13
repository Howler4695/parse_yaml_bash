# Parse Yaml (Native Bash)
#### Got most of script from [this](https://stackoverflow.com/a/21189044/24159511) Github post

### Args
1. yaml source
2. keys to search for
3. delimiter when passung multiple keys (defaults to |)

### Use
`parse_yaml sauce.yml "key1|key2|key3"`

`parse_yaml sauce.yml "key1-key2-key3" "-"`

### How it's different from OG
- is POSIX compliant
- searches for keys
- filters whitespace
- bug in og that would include comments after value

### Problems
- Can't array values
