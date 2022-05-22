# resources for the downloading and understanding some rclone usages
# https://rclone.org/docs/
# https://rclone.org/downloads/
# https://rclone.org/docs/#config-config-file
# https://hcc.unl.edu/docs/handling_data/data_transfer/using_rclone_with_hcc/
# https://rclone.org/commands/rclone_link/
# https://rclone.org/changelog/

# recomended to review basic linux commands before:
# https://hcc.unl.edu/docs/connecting/basic_linux_commands/
#some more detailed functions of rclone
# https://docs.csc.fi/data/Allas/using_allas/rclone/
# -----from here we apply rclone functions--- 

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#important! don't use *update* ! this will erase information on the OSN that isnt found
# in the local file/folder that is being updated. instead use *copy* !
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#this is the address of our bucket in the OSN
https://renc.osn.xsede.org/borneanfrog/
  
  #this is an example with the right credentials to download specific file from the OSN
  
  # The bucket is now private, so therefore one could not just download files without credentials
  # but this is in general the format of the file path:
  
  https://renc.osn.xsede.org/borneanfrog/testfiles/myfile

#we use bash function of "ls" to observe inside the bucket, and folders.
rclone ls "NECT-Bornean Frog":/borneanfrog

#we can delete files, or folders using the "delete" rclone function
# Tip: I would suggest avoiding this function and just do it on the OSN platform
rclone delete "NECT-Bornean Frog":borneanfrog/testportalOSN/
  
  
  #this will be one of the main function that you will be using
  # we won't be updating folders, we will be copying folders (rclone prevents duplicates so no worries there)
  # we will be calling 
  
  #rclone <function> <path to the data file/folder> <OSN bucket reference according to config file>:<bucket name>/<than either existing path, or new path. rclone will create a new folder if it doesn't exist>
  
  #here are 2 examples that i tested the OSN with.
  #the -P flag is to view real time transfer statistics
  # when you insert paths adding / at the end is for a folder, and leaving the path 
# at the end open, is for specific file

rclone copy /projectnb2/ct-shbioinf/ykovalski/finalTest/ref "NECT-Bornean Frog":borneanfrog/ViralReferenceData -P


#--checkpoint ----

#it is important to remmember the order of the destination and source! 

#upload
rclone copy <src> <dst> #this would be an instance of uploading files or folders to the OSN
  
  rclone copy ./justforTest.txt "NECT-Bornean Frog":borneanfrog/exampleSHowT/ -P

#download
rclone copy <dst> <src> #this would be an instance of downloading files or folders to the cluster/local
  
  rclone copy "NECT-Bornean Frog":borneanfrog/testfiles/myfile /projectnb2/ct-borneanfrog/rclone/ -P #this example can error if the OSN layout has been changed

# Tip: you could add the flag of -P to see the progress of the upload or download
# it is important to monitor big datasets since they can take a while

#Tip: if you are able to monitor terminal's current directory, instead of typing the entire
# path, one could just use ./ and that will download or upload the file or folder to where 
# the terminal session is at. 

#in example set the terminal session to the following address:

cd /projectnb2/ct-borneanfrog/rclone

#than download the same file as in line 58 using instead of the entire destination path
# use only ./ 

rclone copy "NECT-Bornean Frog":borneanfrog/testfiles/myfile ./ -P #this example can error if the OSN layout has been changed

# can you see now how there are multiple ways to implement pathways?
#--------
# Note (just extra not necessarily needed) : -v stands for verbose, means additional details about the process will be printed.
rclone -v copy "NECT-Bornean Frog":borneanfrog/testfiles/myfile /projectnb2/ct-borneanfrog/rclone/ -P

#this is an example of downloading file from the OSN. since the destination Folder wasn't existing. rclone creates a new directory and puts the contents inside. 
rclone copy "NECT-Bornean Frog":borneanfrog/ViralReferenceData/viral_all.fasta /projectnb2/ct-borneanfrog/newfolderOSN -P

#this is another example of downloading a folder from the OSN. since the destination Folder wasn't existing. rclone creates a new directory and puts the contents inside. 
rclone copy "NECT-Bornean Frog":borneanfrog/ViralReferenceData/ /projectnb2/ct-borneanfrog/newfolderOSN -P #the name of the new folder can be anything

#rclone can also copy buckets contents on the server from one to another
rclone copy s3:oldbucket s3:newbucket

#another note: if there are two files with the same name, but the contents
# are different, you can use the flag --ignore-existing to force rclone to skip


#--- checkpoint ---
# did you know that you can use delete function of rclone on local directorys and not just OSN?
rclone delete -i /projectnb2/ct-borneanfrog/newfolderOSN/ -P #the name of the new folder can be anything

# following information can be found in:
# https://rclone.org/docs/#config-config-file

#tip: use the -i flag to ensure that when you delete a file that you are certain about it
#also should consider --delete-(before,during, after) since it allows
#faster copying or syncing as well a correct usage in memory space. read in the docs 
#to get an idea as to which one you should use

#--fast-list function 
#->lowers the number of transactions (important if one pays for them)
#->will us more memory, since Rclone has to load the whole listing into memory
#-> it may be faster because it uses fewer transations 
#-> but it may be slower because it can't be parallelized. 
#usually with or without it has same performence results, 
#however it is beneficial for cost but not for larger syncs due to running out of memory space.

#another flag that can be added to rclone's functions is --transfers=N
# -> in this instance N is the number of file transfers to run in parallel. 
# it can sometimes be useful to set this to a smaller number, the default is to run 4 file transfers in parallel.

#-----------------

#the "tree" function allows to see the organization of the files within the bucket or folder
#makes it easier to see what there is in the folder (especialy through the terminal with no website)

rclone tree "NECT-Bornean Frog":/borneanfrog #example 1

rclone tree "NECT-Bornean Frog":/borneanfrog/exampleSHowT/ #example 2
  
  #--checkpoint ---
  #run both rclone tree function examples
  #can you tell the difference between the two outputs?
  #-------------

#----important message -----

# we had mentioned that it is wise not to use sync function in rclone. that is because
# whichever the destination is, will be the one that could lose information or files. 
# the sync will mirror completly the source to the destination content. 
# therefore use the copy or copyto functions instead. 

#how about we test this scenerio just to show:

#lets start by downloading a file into a folder on the cluster from the OSN like earlier

rclone copy "NECT-Bornean Frog":borneanfrog/ViralReferenceData/viral_all.fasta /projectnb2/ct-borneanfrog/newfolderOSN -P

#now sync the OSN with the new folder. and see what happened to the new file in the folder

rclone sync "NECT-Bornean Frog":borneanfrog/testfiles/ /projectnb2/ct-borneanfrog/newfolderOSN -P

# was it as we predicted?
#we can say yes, since now we lost the previous folder content, and are left with what was on the OSN

#------


#--- link and unlink -----
# in the last section of the rclone functions (there are more, you more than 
# welcome to see and test them out)

# this section is in case one does not have credentials to the bucket, and you
# want them to have access. since now the bucket is private, you would need
# to create a public link, that only lets those with the link to have access. 
# so it is still private. as well as one can set an experation timeline. so even
# if the link ended up by someone outside the research group it would be mute

# rclone will link will create, retrieve or remove a public link to the given file or folder:

# these are the various implimantations:

# rclone link remote:path/to/file
# rclone link remote:path/to/folder/
# rclone link --unlink remote:path/to/folder/
# rclone link --expire 1d remote:path/to/file

#start by link (we will keep the link as a default for now):
rclone link "NECT-Bornean Frog":borneanfrog/ViralReferenceData/viral_all.fasta

#once the link had been retrieved from the terminal, we than create a data directory
#and use curl to download the file from the OSN to the cluster


# I have not been able to use wget, so that is a future plan
# but the only reason I was doing these two was because of possibly using "link" because of the access to the OSN

#in bash
curl -o 'viral_all.fasta' 'https://renc.osn.xsede.org/borneanfrog/ViralReferenceData/viral_all.fasta?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=8HM0IHHTCYBSWGPMVWM8%2F20211229%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20211229T045555Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fa13bceeb2bce6842280010241b66249a067d7e07cda70c11a23b58d525432c4'

#this is for R language
download.file('https://renc.osn.xsede.org/borneanfrog/ViralReferenceData/viral_all.fasta?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=8HM0IHHTCYBSWGPMVWM8%2F20211229%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20211229T045555Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fa13bceeb2bce6842280010241b66249a067d7e07cda70c11a23b58d525432c4',
              'Vall.fasta')


#for 29th of decemeber meeting we will implement all three ways, excpet for wget. dont know why it isnt working...

curl -o 'SRR10907334_2.fastq.gz' 'https://renc.osn.xsede.org/borneanfrog/Dendrobates_tinctorisus_RNASeq/test/SRR10907334_2.fastq.gz'

#and this is the prefered way the rclone
rclone copy "NECT-Bornean Frog":/borneanfrog/Dendrobates_tinctorisus_RNASeq/test/SRR10907334_1.fastq.gz ./ -P

#--------other------------------------------------------
# this is a way to create a new directory localy, 
# than construct text/file using shell code.
# than copy the new file/directory to the OSN

mkdir testportalOSN #create dir
echo "this is text" > testportalOSN/type #construct file
rclone copy ./gettingStartedGoogleDoc/ "NECT-Bornean Frog":borneanfrog/gettingStartedGoogleDoc #copy file/folder to the OSN


#this line of code I was using to load the data from the NCBI to the OSN
#I read today https://rclone.org/changelog/ that possibly the process
# could had been more effecient in cost or faster in time, when loading the OSN

# -> since I was capped also in space, so i had to delete as I loaded, via the link it 

# shows how to utulize one of the flags towards deleting files as they are loaded to the cloud. 
rclone copy ./Dendrobates_tinctorisus_RNASeq "NECT-Bornean Frog":borneanfrog/Dendrobates_tinctorisus_RNASeq/ 
  
  #he line before was what i did than, and next one is what I would do now (possibly useful for the transcriptions)