BASEDIR=`pwd`

# generating a signing certificate
# openssl genrsa 1024 > pk-<id>.pem
# openssl req -new -x509 -nodes -sha1 -days 730 -key pk.pem -out cert-<id>.pem

[ -z "$AWS_CRED_HOME" ] && CRED_HOME=$BASEDIR/id
[ -z "$REMOTE_ROOT" ] && REMOTE_ROOT="ubuntu"

[ ! -d $AWS_CRED_HOME ] && echo "Credential path does not exist: $AWS_CRED_HOME"

echo "Using AWS credentials: $AWS_CRED_HOME"

export PATH=$EC2_HOME/bin:$PATH
export EC2_PRIVATE_KEY=`find $AWS_CRED_HOME -name pk-*.pem`
export EC2_CERT=`find $AWS_CRED_HOME -name cert-*.pem`

AWS_ACCESS_KEY_FILE=$AWS_CRED_HOME/accesskey
AWS_SECRET_KEY_FILE=$AWS_CRED_HOME/secretkey

export AWS_ACCESS_KEY=`cat $AWS_ACCESS_KEY_FILE`
export AWS_SECRET_KEY=`cat $AWS_SECRET_KEY_FILE`

export EC2_SSH_KEY=`find $AWS_CRED_HOME -name 'id_*' ! -name '*.pub'`
export EC2_SSH_KEY_NAME=${EC2_SSH_KEY/*id_}

export EC2_SSH_OPTS="-i "$EC2_SSH_KEY" -o StrictHostKeyChecking=no -o ServerAliveInterval=30"

function ec2proxy {
 HOST=$1
 ssh $EC2_SSH_OPTS -D 6666 -N "$REMOTE_ROOT@$HOST"
}

function ec2screen
{
  ssh $EC2_SSH_OPTS -t "$REMOTE_ROOT@$1" 'screen -s -$SHELL -D -R'
}

function ec2login
{
  ssh $EC2_SSH_OPTS -t "$REMOTE_ROOT@$1"
}
