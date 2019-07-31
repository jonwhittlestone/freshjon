# Dotfiles


---
## Reinstall Ubuntu Log

### Pre-automated Script

1. bitwarden
    
        sudo snap install bitwarden

 2. Log in with Firefox Sync for bookmarks
 
 3. ssh server - https://t.ly/8Xgj
        
        sudo apt update
        sudo apt install openssh-server -y

 4. Generate new SSH key 
 
        ssh-keygen -t rsa -b 4096 -C "temp@howapped.com"
        
        
  5. Install git
  
            sudo apt update
            sudo apt install git -y

   6. Make directory for ~/code
   
            mkdir ~/code
            cd ~/code

    7. Clone old_dotfiles into ~/code/dotfiles/salvaged
    
            git clone https://jonwhittlestone@bitbucket.org/jonwhittlestone/old_dotfiles.git ~/code/dotfiles/salvaged

    8. Copy salvaged ssh keys etc

    9. Install VSCode for Editing dotfiles

            sudo snap install code --classic

    10. Get settings sync extension for downloading
    seeings from Gist


### Run Script for dev deps

11. `bash install.sh --zsh --install-devtools`

### Linux Software

12. `bash linux.sh`
