# rofi-pass

## Description
- Works similarly to `passmenu --type`
- Uses Rofi to enter passwords stored with Pass into your web browser
- Either a username, password, or both can be inputted via the script

## Requirements
- On Arch Linux, with *yay*:
```sh
yay -S rofi pass xdotool
```

## Usage
- The script assumes your password store is located at `~/.password-store`
- Add passwords to the store if not already done
- Download the script and make it executable
- Create a keybinding for the script
- Browse to a site, and click on a username or password entry field (if using a vim-like browser like Qutebrowser, make sure you're in Insert Mode)
- Run the script via the keybinding

## Important note on formatting
- The number of lines in the password store file determines the functionality of the script:
  - If the number of lines is equal to *one*, it's assumed that either a username *or* password is contained in the file
  - If, however, the number of lines is greater than one, it's assumed that:
    - The first line of the file is the username
    - The last line of the file is the password
- See the following examples:

### Example 1: Discrete credentials
- Where the bold headers show the file path and the block text indicates the file contents:
#### `~/.password-store/somesite/user`
```
myusername
```
#### `~/.password-store/somesite/pass`
```
mypassword123 
```

### Example 2: Defragmented credentials
#### `~/.password-store/somesite`
```
myusername
mypassword123 
```
