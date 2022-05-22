# resources for the downloading and understanding some rclone usages
# https://rclone.org/docs/
# https://rclone.org/downloads/
# https://rclone.org/docs/#config-config-file
# https://hcc.unl.edu/docs/handling_data/data_transfer/using_rclone_with_hcc/ 

# #it is recomended to have a source folder where all the programs, softwares,
# and downloaded modules sit in, so there is a sense of what needs to be obtained/updated
# as well as it makes it easier to have same "path" across the projects to centraled folder

#now lets set up

#-----download rclone to linux/terminal-----###

#create/open source folder

#https://linuxpip.org/rclone-examples/  #Use_rclone_to_copy_one_file

#if there is not a src directory than one is created. 

if[! -d "~/src"]
then
mkdir ~/src
fi

#than we move into src folder.
cd ~/src

#than we are saying if rclone was not downloaded than 
#it will download the rclone into the src directory.

if[! -d "~/rclone"]
then
mkdir ~/rclone
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
mv rclone-*-linux-amd64 rclone
fi

# note: this is optional, you can either module load rclone, with 
# each terminal session, or export in .bashrc as the following. 
#your choice!


#We can update terminal modules by editing .bashrc
cd ~
  nano .bashrc
#add to the aliases and functions the following line, than exit and save (contorl-x, than enter)
export PATH=$PATH:~/src/rclone
#than restart the terminal

##--- now you have downloaded the rclone. good job! now continue to SetUp_Rclone.sh --- 