
openssl req -new -newkey rsa:4096 -nodes -out projectname.csr -keyout projectname.key
openssl req -new -key projectname.key -out projectname_20181207.csr
openssl req -noout -text -in projectname.csr
