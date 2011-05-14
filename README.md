bash-ec2
========

This is a simple set of bash functions for manipulating
Amazon EC2 instances.

This work is licensed under a [Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/).

Install
-----

You must install the [ec2-api-tools client](http://aws.amazon.com/developertools/351).

You then must set the EC2_HOME environment variable to the client install root directory.

    export EC2_HOME=/path/to/ec2-api-tools

Next a directory with all your AWS credentials must be created. For example

    mkdir aws; cd aws

    echo <accesskey> > accesskey
    echo <secretkey> > secretkey

Where <accesskey> and <secretkey> are your AWS credentials.

You must also create and register signing keys

    openssl genrsa 1024 > pk-<id>.pem
    openssl req -new -x509 -nodes -sha1 -days 365 -key pk.pem -out cert-<id>.pem

Where <id> is some optional unique identifier.

Finally your private key should be added in order use the below aliases. 
Your private key must begin with "id_".

Finally, you must source the setenv.sh file after setting the path
to your credentials.

    export AWS_CRED_HOME=~/aws

then in the ec2-bash install directory

    . setenv.sh

Usage
-----

### ec2login
Will remotely login to the master node. 

### ec2creen
Will launch screen on the master node. Screen must be already installed.
If a screen instance is already running, this command will automatically attach.

### ec2proxy
Will create a local SOCKS proxy to the master node. You must install 
FoxyProxy in FireFox for this to work best.