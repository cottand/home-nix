#!/usr/bin/env fish

# AI-powered command generation using Claude CLI

function ask_claude -d "Generate commands using Claude AI"
    # Check if arguments were provided
    if test (count $argv) -eq 0
        echo "Error: No command specified"
        echo "Usage: ask_claude your question here"
        echo "       fix_last_command - to debug the last failed command"
        return 1
    end

    # Join all arguments as the user prompt
    set -l user_prompt (string join ' ' $argv)

    # Get system information for context
    set -l system_info (uname -s)
    set -l shell_type "fish"

    # Create a prompt that asks for shell commands
    set -l full_prompt "Generate a shell command for $system_info using $shell_type shell. Only respond with the command, no explanation: $user_prompt"

    # Use claude -p to get the response
    set -l cmd (claude -p "$full_prompt")
    
    if test $status -ne 0
        set_color red
        echo "Error: Claude command failed"
        set_color normal
        return 1
    end

    # Clean up the response (remove any extra whitespace or quotes)
    set cmd (string trim "$cmd")
    
    # Put the command on the command line but don't execute
    commandline -r "$cmd"
end

function fix_last_command -d "Fix the last failed command using Claude AI"
    # Get the last command from history
    set -l last_cmd (history | head -n 1)

    # Remove leading/trailing whitespace
    set last_cmd (string trim $last_cmd)

    # Skip if the last command was ask_claude or fix_last_command
    if string match -q "ask_claude*" $last_cmd; or string match -q "fix_last_command*" $last_cmd
        set_color yellow
        echo "No previous command to fix (last command was ask_claude or fix_last_command)"
        set_color normal
        return 1
    end

    if test -z "$last_cmd"
        set_color yellow
        echo "No previous command found in history"
        set_color normal
        return 1
    end

    set_color yellow
    echo "🔍 Analyzing failed command: $last_cmd"
    set_color normal

    # Create fix prompt and call ask_claude
    ask_claude "The command '$last_cmd' failed. Please provide a corrected version or alternative approach."
end