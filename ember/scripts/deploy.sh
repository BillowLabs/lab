
DEPLOY_DIR=deploy
DIST_DIR=dist

UNDERLINE='\033[4m'
RED='\033[0;31m'
CYAN='\033[01;36m'
GREEN='\033[01;32m'
RESET='\033[0m' # No Color

function header {
	echo -e ${UNDERLINE}${CYAN}$1${RESET}
}


if [ -z ${SF_TOKEN+x} ]; then
	echo -e "${RED}You need to configure the SF_TOKEN environment variable${RESET}"
elif [ -z ${SF_USER+x} ]; then
	echo -e "${RED}You need to configure the SF_USER environment variable${RESET}"
elif [ -z ${SF_RESOURCE+x} ]; then
	echo -e "${RED}You need to configure the SF_RESOURCE environment variable${RESET}"
else

	header "\nUsing Settings:"
	echo "Deploy Directory: $DEPLOY_DIR"


	header "\nCleaning Deploy Directory"
	rm -fr $DEPLOY_DIR
	wait
	echo "Cleaned"


	header "\nCreating TEMP Mavens Mate Project"
	FILE="{\"name\" : \"$DEPLOY_DIR\",\"workspace\" : \".\",\"username\" : \"$SF_USER\",\"password\" : \"$SF_TOKEN\",\"package\" : {\"StaticResource\" : \"*\"}}"
	mavensmate new-project <<< $FILE
	wait
	echo "Project created"


	header "\nCreating Resouce Bundle"
	cd $DEPLOY_DIR
	mavensmate new-resource-bundle src/staticresources/$SF_RESOURCE.resource
	wait


	header "\nRebuilding Ember project for Production"
	ember build --environment=production --output-path=$DIST_DIR
	wait


	header "\nCleaning out old resource bundle"
	rm -fr resource-bundles/$SF_RESOURCE.resource/**/*
	rm -fr resource-bundles/$SF_RESOURCE.resource/*
	wait
	echo "Bundle emptied"


	header "\nCopying new build to resource bundle"
	cp -fr ../$DIST_DIR/.  ./resource-bundles/$SF_RESOURCE.resource/
	mavensmate deploy-resource-bundle resource-bundles/$SF_RESOURCE.resource/
	cd ..

fi
