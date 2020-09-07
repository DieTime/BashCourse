# Bash2md Writer

### About
Application to automate filling markdown files when running bash scripts.

### How start?

Compile app
```bash
gcc main.c -o bash2md
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
sudo ./bash2md <script/path/important> <markdown/path/optional>
```

### Example

```bash
sudo ./bash2md ./example.sh
```

```bash
sudo ./bash2md ./example.sh ./CUSTOM.md
```