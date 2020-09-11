# Bash2md Writer

### About
Application to automate filling markdown files when running bash scripts.

### How start?

Clone repository
```bash
git clone https://github.com/DieTime/bash2md.git
cd bash2md/
```

Compile app
```bash
gcc bash2md.c -o bash2md
```

Write bash script in .sh file
```bash
#!/bin/bash
#Example script <- Important header for future .md file
for (( c=1; c<=5; c++ ))
do
   echo "Welcome $c times"
done
```

Run app
```bash
sudo ./bash2md <script/path/important> <markdown/path/optional(./README.md)>
```

### Example

```bash
# Dont forget remove old README.md file
sudo ./bash2md ./example.sh
```

```bash
sudo ./bash2md ./example.sh ./CUSTOM.md
```