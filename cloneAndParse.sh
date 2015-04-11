###############################################################################
# CONFIGURATION
###############################################################################

# create the file %userprofile%\_netrc
# content:
# machine stash.taskforce47.de
#	login <username>
#	password <password>

#STASH_REPOSITORY="http://${STASH_USER}:${STASH_PASSWORD}@stash.taskforce47.de/scm/aiii/tf47-patrolops-altis.git"
STASH_REPOSITORY="$1"
TARGET_DIR="$2"
CURRENT_PATH=$(pwd)

chmod -R 777 "$TARGET_DIR"

###############################################################################
# MAIN STUFF
###############################################################################

if [ -d "$TARGET_DIR" ] 
then
	echo "remove existing mission directory '$TARGET_DIR'"
	rm -Rf "$TARGET_DIR"
fi

# clone repository
echo "clone '$STASH_REPOSITORY' to '$TARGET_DIR'"
git clone "$STASH_REPOSITORY" "$TARGET_DIR"

cd "$TARGET_DIR"
VERSION=$(git describe)

echo "Repository Version: $VERSION"

MAINVERSION=$(echo $VERSION | cut -d "-" -f1)
COMMITSBEHIND=$(echo $VERSION | cut -d "-" -f2)
SHORTHASH=$(echo $VERSION | cut -d "-" -f3)

MAJOR=$(echo $MAINVERSION | cut -d "." -f1)
MINOR=$(echo $MAINVERSION | cut -d "." -f2)
BUGFIX=$COMMITSBEHIND

VERSION="$MAJOR.$MINOR.$BUGFIX"

if test "$MAINVERSION" = "$COMMITSBEHIND"
then 
	VERSION="$MAJOR.$MINOR"
fi

# parse stuff form README.md
MISSION_NAME=$(cat README.md|grep NAME_TPL | cut -d "[" -f2 | cut -d "]" -f1 | sed "s/{VERSION}/$VERSION/g")

echo "write '$MISSION_NAME' to files"
# replace MISSION_NAME in cfgTF47.sqf and mission.sqm
FILES="cfgTF47.sqf mission.sqm stringtable.xml"
for file in $FILES
do
	cat "$file" | sed "s/{MISSIONINFO}/$MISSION_NAME/g" > "$file.new"
	mv "$file.new" "$file"
done

cd "$CURRENT_PATH"
# remove .git directory
echo "remove .git directory inside '$TARGET_DIR'"
rm -Rf "$TARGET_DIR/.git"

echo "remove .gitignore inside '$TARGET_DIR'"
rm -f "$TARGET_DIR/.gitignore"

echo "remove README.dm inside '$TARGET_DIR'"
rm -f "$TARGET_DIR/README.md"