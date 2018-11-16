#!/bin/bash
echo '----------'
echo '----- Preparing to install Hadoop on Multiple Nodes -----'
echo '----- Amazon Web Services EC2 ------'
echo '----- Ubuntu Server 16.04 LTS (HVM), SSD Volume Type -----'
echo '----------'

cd $HADOOP_INSTALL/etc/hadoop

# Set $JAVAHOME
sed -i 's%${JAVA_HOME}%/usr/lib/jvm/java-8-openjdk-amd64/%' hadoop-env.sh
# Configure core-site.xml
sed -i 's%<configuration>%<configuration>\n\t<property>\n\t\t<name>fs.defaultFS</name>\n\t\t<value>hdfs://master:9000/</value>\n\t</property>%' core-site.xml
# Configure hdfs-site.xml
sed -i 's%<configuration>%<configuration>\n\t<property>\n\t\t<name>dfs.replication</name>\n\t\t<value>2</value>\n\t</property>\n\t<property>\n\t\t<name>dfs.blocksize</name>\n\t\t<value>134217728</value>\n\t</property>\n\t<property>\n\t\t<name>dfs.namenode.name.dir</name>\n\t\t<value>/home/ubuntu/hadoop/hdfs/name</value>\n\t</property>\n\t<property>\n\t\t<name>dfs.datanode.data.dir</name>\n\t\t<value>/home/ubuntu/hadoop/hdfs/data</value>\n\t</property>\n\t<property>\n\t\t<name>dfs.namenode.checkpoint.dir</name>\n\t\t<value>/home/ubuntu/hadoop/hdfs/namesecondary</value>\n\t</property>%' hdfs-site.xml
# Create mapred-site.xml from template mapred-site.xml.template
cp mapred-site.xml.template mapred-site.xml
# Configure mapred-site.xml
sed -i 's%<configuration>%<configuration>\n\t<property>\n\t\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.jobhistory.intermediate-done-dir</name>\n\t\t<value>/home/ubuntu/hadoop/mr-jobhistory/tmp</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.jobhistory.done-dir</name>\n\t\t<value>/home/ubuntu/hadoop/mr-history/done</value>\n\t</property>%' mapred-site.xml
# Configure yarn-site.xml
sed -i 's%<configuration>%<configuration>\n\t<property>\n\t\t<name>yarn.nodemanager.hostname</name>\n\t\t<value>master</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.nodemanager.local-dirs</name>\n\t\t<value>/home/ubuntu/hadoop/rm_local_dir</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.nodemanager.aux-services</name>\n\t\t<value>mapreduce_shuffle</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>\n\t\t<value>org.apache.hadoop.mapred.ShuffleHandler</value>\n\t</property>%' yarn-site.xml

echo '----------'
echo '----- Logout and log back in to apply changes -----'
echo '----------'