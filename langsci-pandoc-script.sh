#!/bin/bash


$PATH = "/projects/pdf_eval/data/langsci_books"
#i have no idea where anythign goes
$OUTPATH="~/langsci_txt1-22"        #probablly should remove the "/chapters" part if it's present
#$YAMLFILE = "$PATH/langsci.yml"
$YAMLFILE = "~/langsci.yml" #let's just make extra sure i have permissions'
#/projects/pdf_eval/bin/pandoc --from=latex --to=plain -s "$FULLPATH/$FILE.tex" -o "$OUTPATH/$FILE.txt"

# i need a loop "for directory in langsci_books"
# i also need a loop "for file in directory that ends in .tex" -- then strip off the .tex and 
# save name as $FILE.txt

#ok outline time:
    # we're going to go through each directory in langsci_books
    # then we see if there's a "chapters" folder, if there is we go there
    # for every file that ends in .tex, we run the command

#for dir in $PATH; do
    #if main.tex exists, we probably want that?

    #we also want all .tex files in the dir chapters if it exists    
for dir in */ ; do
    cd "$PATH/$dir"
    # here we want to add $dir to yaml file
    echo "$dir: \n" > $yaml   # --do i need two >>s?
	#no, i only want to add the dir if it has something in it
	#fuck it i'll add them all, maybe i can remove blank ones later? or they can just be there

    if [ -e "main.tex" ]; then 
        /projects/pdf_eval/bin/pandoc --from=latex --to=plain -s main.tex \
        -o $OUTPATH/$dir_main.txt
        #and add to yaml file
        echo " - main \n"
        echo "main found for $dir"
    fi
    if [ -d "chapters" ]; then
        echo "chapters dir found for $dir\n"
        for file in /chapters/*.tex ; do
            
            if /projects/pdf_eval/bin/pandoc --from=latex --to=plain -s main.tex \
            -o $OUTPATH/chapters/$dir_$file.txt ; then
				#add to yaml file
				echo " - $file \n"
        done
    fi
    echo "$dir finished\n"
done

exit 0