# see if this is how i will do the the menu. otherwise I will
# just do an easy shiny app for log in


#this link below is a link to the university of Nebrska's HOllanf computing
#center HCC-DOCS.  they introduce to high performance computting(HPC) enviorment like our
#BU cluster. they show how to handle data using rclone among other methods. 
#worth invistigating into other ways that might fit better. i used rclone
# but it isnt the only way, or the best way

#https://hcc.unl.edu/docs/handling_data/data_transfer/using_rclone_with_hcc/

#unless rclone or any module has been added to bashrc (hence modules are loaded
# in each terminal session), we would need to module load <moduleName> in order to use it

#this is how we load the rclone module 
module load rclone

#than we apply the function that we desire 
#each function has a different function structure. you should refer back to https://rclone.org/docs/
# or just run the following line in the terminal and read the available commends:
rclone

#we should start by making sure that we have the config file with the correct credentials

#this next line will allow to see the current remotes associated to the session in the terminal
#follow the instructions according to what you need
rclone config 


rclone config file #this will give you the file path. 

# ---- check point ---

# why would you want or need to know the config file location?

# the answer to that is that working in config mode might be confusing with its many steps.
# therefore I rather complete this stage in one of the following two ways:

# we can either change information of the crednetials, the bucket name, or even 
# add different buckets that we will have access to once we load the rclone
# module to the current terminal's session. by going to the phyical location of 
# the file and change.

# -------
# Tip: if there is an error than do line 48 before the rest.

cd ~ #since we are refering to the entire path we will set to home before
# Get config path from rclone
config=$(rclone config file)
# Remove everything except the path
RCLONE_CONFIG="/${config#*/}"
export RCLONE_CONFIG

# the first way

#type after the nano whichever config path shows or go to the textfile of config and place info in there

#Tip: by the way control or command X will exit the nano mode. 
nano $RCLONE_CONFIG

#example to what it would look like:
nano /usr2/collab/ykovalsk/.config/rclone/rclone.conf


# the second way:

# if it is easier for you run the following code:
echo $RCLONE_CONFIG

# copy the path from the terminal 
# (have to use the mouse copy and print on the cluster)
# and than apply it in the console:

#general format
file.edit("<file path>") 

#here is the example 
file.edit("/usr2/collab/ykovalsk/.config/rclone/rclone.conf")

# now you can apply changes, or add new buckets of choice
# within the nano terminal (this writes directly to the config file)

# this should be the layout of a bucket in the config file:

[<Name of the Bucket>]
type = s3
provider = Ceph
access_key_id = <the Access key posted on the OSN>
secret_access_key = <the secret access key posted on the OSN>
endpoint = https://renc.osn.xsede.org

# this is an example of mine:

[NECT-Bornean Frog]
type = s3
provider = Ceph
access_key_id = 8HM0IHHTCYBSWGPMVWM8
secret_access_key =xK4zkeDlnv6uIN1FrMsZw3tCJ+R9WR
endpoint = https://renc.osn.xsede.org


# ------now we are done with setting up ----