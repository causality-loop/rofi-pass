# rofi-pass

## Description
- Works similarly to the [Qutebrowser Pass script](https://github.com/qutebrowser/qutebrowser/blob/master/misc/userscripts/qute-pass) and `passmenu --type` 
- Uses *Rofi* to output passwords stored with *Pass*
- Either a username, password, or both can be inputted via the script (see [Usage](#usage))
- Please read the [Notes](#notes) and [Known Issues](#known-issues) sections

## Requirements
- A non-Vim like browser with the *Vimium* extension installed:
  - [Vimium-FF Firefox](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/)
  - [Vimium Chrome](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en)
- On Arch Linux, with *yay*:
```sh
yay -S rofi pass xdotool xclip
```

## Usage
### Setup
- The script assumes your password store is located at `~/.password-store`
- Download the script and make it executable
- Create a keybinding for the script
### The `--both` flag
- Example:
```
./rofi-pass.sh --both
```
- Works like `passmenu --type`, but both username and password will be inputted into the appropriate fields in a web browser (as with the [Qutebrowser script](#description) above)
- Password store file names should be the URL minus the `http://` and any other text after `.com` (or `.net`, `.org`, `.me`, `.io`, etc); example:
  - URL: `https://login.myemail.me/user-login-screen`
  - Password store entry: `login.myemail.me`
- Password store files should contain the username/email in the first line and the password in the last line; example:
```
myusername
password123
```
- To use the script after setting up *Pass*, simply browse to the site and type the script keybinding; the username/email and password should be entered in both fields, respectively
### Without flags
```
./rofi-pass.sh
```
- Works like `passmenu --type`
- Password store entries need not submit to any specific format outside those recommended by the developers of *Pass*
- To use the script after setting up *Pass*, type the keybinding and select which password store entry you'd like typed out from the *Rofi* menu

## Notes
- Only tested on Arch Linux using the following browsers: 
  - Firefox
  - Librewolf
  - Brave
- Ensure that the `yy` and `gi` commands in Vimium haven't been changed or unmapped

## Known issues
### Brave
##### Description
- Using the `--both` flag causes the Brave Task Manager to run instead of producing the intended resultant
##### Reason
- A keybinding inherent to Brave (`Shift+Esc`) conflicts with the code on `Line 11` (`xdotool key Escape`)
##### Fix
  - Comment the aforementioned line
  - Rerun the script in Brave, ensuring that neither text field is selected (click on the page outside the text fields)
