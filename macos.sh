#macos.sh MAC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN MAC_REALNAME

#disable spotlight indexing
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/Gurpreet
sudo dscl . -create /Users/Gurpreet UserShell /bin/bash
sudo dscl . -create /Users/Gurpreet RealName $4
sudo dscl . -create /Users/Gurpreet UniqueID 1001
sudo dscl . -create /Users/Gurpreet PrimaryGroupID 80
sudo dscl . -create /Users/Gurpreet NFSHomeDirectory /Users/tcv
sudo dscl . -passwd /Users/Gurpreet "$MAC_USER_PASSWORD"
sudo dscl . -passwd /Users/Gurpreet "$MAC_USER_PASSWORD"
sudo createhomedir -c -u Gurpreet > /dev/null
sudo dscl . -append /Groups/admin GroupMembership username

#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes

echo $2 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#Change Display Resolution 
brew install displayplacer
displayplacer "id:1280x720"




#Android Studio


wget https://redirector.gvt1.com/edgedl/android/studio/install/2022.2.1.20/android-studio-2022.2.1.20-mac.dmg

sudo hdiutil attach android-studio-2022.2.1.20-mac.dmg


sudo cp -R /Volumes/Android\ Studio\ -\ Flamingo\ \|\ 2022.2.1\ Patch\ 2/Android\ Studio.app /Applications







#JumpDesktop


wget https://mirror.jumpdesktop.com/downloads/connect/JumpDesktopConnect-6.5.39.dmg

sudo hdiutil attach JumpDesktopConnect-6.5.39.dmg

sudo installer -pkg /Volumes/Jump\ Desktop\ Connect/.jdc.sparkle_guided.pkg -target /


sudo hdiutil detach /Volumes/Android\ Studio\ -\ Flamingo\ \|\ 2022.2.1\ Patch\ 2

sudo hdiutil detach /Volumes/Jump\ Desktop\ Connect



#install ngrok
brew install ngrok/ngrok/ngrok

#configure ngrok and start it
ngrok authtoken 2QkSTXbiPTkw9WNRPOnhJCQXlfM_87JE1CPwtLKCQPQmRqGEn
ngrok tcp 5900 --region=in &