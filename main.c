#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

FILE* open_file(const char* file_path, const char* mode, const char* error_message);

void close_file(FILE* file, const char* file_path);

void system_command(const char* command);

void file_content_to_md(const char* script_path, const char* content_type, const char* md_path);

int file_exists(const char* filename);

int file_empty(FILE* file);

int main(int argc, char** argv) {
    // Return if app run without sudo
    if (geteuid() != 0) {
        fprintf(stderr, "Error! Please run app with sudo!\n");
        return 1;
    }

    // Return if no file path in parameters
    if (argc < 2) {
        fprintf(stderr, "Error! Please add filename as parameter!\n");
        return 2;
    }

    char* script_path = argv[1];  // Path to .sh file
    char* md_path = "README.md";  // Path to .md file
    char* temp_path = ".bash2md"; // Path to .bash2md temp file

    char access_rights_command[256]; // Command for get +x access rights
    char exec_command[256];          // Command for run bash script
    char remove_command[256];        // Command for remove temp file

    // Generate access rights command
    sprintf(access_rights_command, "chmod +x %s", script_path);

    // Generate execute command
    sprintf(exec_command, "%s > %s", script_path, temp_path);

    // Generate remove command
    sprintf(remove_command, "rm -f %s", temp_path);

    // Set markdown file if it is in parameters
    if (argc > 2) md_path = argv[2];

    // Return if script not exists
    if (!file_exists(script_path)) {
        fprintf(stderr, "Error! File %s doesn't exists!\n", script_path);
        return 3;
    }

    // Get access rights
    system_command(access_rights_command);

    // Run script
    system_command(exec_command);

    // Append data to markdown file
    file_content_to_md(script_path, "bash", md_path);
    file_content_to_md(temp_path, "text", md_path);

    // Remove temp file
    system_command(remove_command);

    printf("%s was successfully updated!\n", md_path);
    return 0;
}

int file_exists(const char* filename) {
    struct stat buffer;
    return (stat(filename, &buffer) == 0);
}

FILE* open_file(const char* file_path, const char* mode, const char* error_message) {
    FILE* result = fopen(file_path, mode);
    if (result == NULL) {
        fprintf(stderr, "%s", error_message);
        exit(4);
    }
    if (file_empty(result)) {
        fprintf(stderr, "Warning! %s is empty!\n", file_path);
        exit(4);
    }
    return result;
}

void close_file(FILE* file, const char* file_path) {
    if (fclose(file) == EOF) {
        fprintf(stderr, "Warning! File %s wasn't closed successfully!\n", file_path);
        exit(5);
    }
}

void system_command(const char* command) {
    if (system(command) != 0) {
        fprintf(stderr, "Error! command wasn't executed!\n");
        exit(6);
    }
}

void file_content_to_md(const char* script_path, const char* content_type, const char* md_path) {
    // Buffer fo reading
    int buffer_length = 128;
    char buffer[buffer_length];

    // Open content and markdown files
    FILE* file_content = open_file(script_path, "r", "Error! Can't get script text!\n");
    FILE* md_file = fopen(md_path, "a");

    // Write content to markdown file if it is empty
    if (file_empty(md_file)) {
        fprintf(md_file, "# Bash course\n");
    }

    // Write title to markdown file if content type is bash
    if (strcmp(content_type, "bash") == 0) {
        for (int i = 0; i < 2; i++) {
            if (fgets(buffer, buffer_length, file_content) == NULL || buffer[0] != '#') {
                fprintf(
                    stderr, "Error! %s doesn't have correct header!\nExample:\n#!/bin/bash\n#Lesson 1\n",
                    script_path
                );
                close_file(file_content, script_path);
                exit(7);
            }
        }
        fprintf(md_file, "\n#### %s", &buffer[1]);
    }

    // Write block of code to markdown file
    fprintf(md_file, "\n```%s\n", content_type);
    while (fgets(buffer, buffer_length, file_content) != NULL) {
        fprintf(md_file, "%s", buffer);
        if (buffer[strlen(buffer) - 1] != '\n') {
            fprintf(md_file, "\n");
        }
    }
    fprintf(md_file, "```\n");

    // Close all files
    close_file(file_content, script_path);
    close_file(md_file, md_path);
}

int file_empty(FILE* file) {
    int result;

    fseek(file, 0, SEEK_END);
    result = (ftell(file) == 0);
    fseek(file, 0, SEEK_SET);

    return result;
}