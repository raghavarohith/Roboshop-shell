echo -e "\e[33m Install python \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[33m Add application use \e[0m"
useradd roboshop &>>/tmp/roboshop.log


echo -e "\e[33m Create application directory \e[0m"

rm-rf /app &>>/tmp/roboshop.log
mkdir /app

echo  -e "\e[33m Download the application content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app

echo -e  "\e[33m Extract Application content \e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log


echo -e "\e[33m Install Application Depedencies \e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log



echo -e "\e[33m Setup SystemD File \e[0m"
cp home/centos/Roboshop-shell/payment.service /etc/systemd/system/payment.service

echo  -e "\e[33m  Start Payment Service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log


