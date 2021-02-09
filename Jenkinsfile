pipeline
{
    agent any
    stages 
	{
	stage('test')
	    {
		steps
		    {
    			withCredentials([string(credentialsId: 'acc', variable: 'access')]) { //set SECRET with the credential content
        		//echo "My secret text is '${access}'"
				withCredentials([string(credentialsId: 'sec', variable: 'secr')]) { //set SECRET with the credential content
        			//echo "My secret text is '${secr}'"
					withCredentials([file(credentialsId: 'kp', variable: 'k_p')]) {
						withCredentials([file(credentialsId: 'kp2', variable: 'k_p2')]) {
				sh 'terraform init -no-color'
				sh 'terraform apply -auto-approve -no-color -var "acc=$access" -var "sec=$secr" -var "key_p=$k_p" -var "key_p2=$k_p2"'
			}
    		}
				}
			}
		}
	    }
	}
}
