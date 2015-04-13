# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Set Hadoop-specific environment variables here.

# The only required environment variable is JAVA_HOME.  All others are
# optional.  When running a distributed configuration it is best to
# set JAVA_HOME in this file, so that it is correctly defined on
# remote nodes.

# The java implementation to use.
JAVA_HOME=/usr/local/java/jdk1.8.0_25
export JAVA_HOME=${JAVA_HOME}

# The jsvc implementation to use. Jsvc is required to run secure datanodes
# that bind to privileged ports to provide authentication of data transfer
# protocol.  Jsvc is not required if SASL is configured for authentication of
# data transfer protocol using non-privileged ports.
#export JSVC_HOME=${JSVC_HOME}

export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"}

# Extra Java CLASSPATH elements.  Automatically insert capacity-scheduler.
for f in $HADOOP_HOME/contrib/capacity-scheduler/*.jar; do
  if [ "$HADOOP_CLASSPATH" ]; then
    export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$f
  else
    export HADOOP_CLASSPATH=$f
  fi
done

# The maximum amount of heap to use, in MB. Default is 1000.
#export HADOOP_HEAPSIZE=
#export HADOOP_NAMENODE_INIT_HEAPSIZE=""

# Extra Java runtime options.  Empty by default.
export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true"

# Command specific options appended to HADOOP_OPTS when specified
export HADOOP_NAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_NAMENODE_OPTS"
export HADOOP_DATANODE_OPTS="-Dhadoop.security.logger=ERROR,RFAS $HADOOP_DATANODE_OPTS"

export HADOOP_SECONDARYNAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_SECONDARYNAMENODE_OPTS"

export HADOOP_NFS3_OPTS="$HADOOP_NFS3_OPTS"
export HADOOP_PORTMAP_OPTS="-Xmx512m $HADOOP_PORTMAP_OPTS"

# The following applies to multiple commands (fs, dfs, fsck, distcp etc)
export HADOOP_CLIENT_OPTS="-Xmx512m $HADOOP_CLIENT_OPTS"
#HADOOP_JAVA_PLATFORM_OPTS="-XX:-UsePerfData $HADOOP_JAVA_PLATFORM_OPTS"

# On secure datanodes, user to run the datanode as after dropping privileges.
# This **MUST** be uncommented to enable secure HDFS if using privileged ports
# to provide authentication of data transfer protocol.  This **MUST NOT** be
# defined if SASL is configured for authentication of data transfer protocol
# using non-privileged ports.
export HADOOP_SECURE_DN_USER=${HADOOP_SECURE_DN_USER}

# Where log files are stored.  $HADOOP_HOME/logs by default.
#export HADOOP_LOG_DIR=${HADOOP_LOG_DIR}/$USER

# Where log files are stored in the secure data environment.
export HADOOP_SECURE_DN_LOG_DIR=${HADOOP_LOG_DIR}/${HADOOP_HDFS_USER}

###
# HDFS Mover specific parameters
###
# Specify the JVM options to be used when starting the HDFS Mover.
# These options will be appended to the options specified as HADOOP_OPTS
# and therefore may override any similar flags set in HADOOP_OPTS
#
# export HADOOP_MOVER_OPTS=""

###
# Advanced Users Only!
###

# The directory where pid files are stored. /tmp by default.
# NOTE: this should be set to a directory that can only be written to by 
#       the user that will run the hadoop daemons.  Otherwise there is the
#       potential for a symlink attack.
export HADOOP_PID_DIR=${HADOOP_PID_DIR}
export HADOOP_SECURE_DN_PID_DIR=${HADOOP_PID_DIR}

# A string representing this instance of hadoop. $USER by default.
export HADOOP_IDENT_STRING=$USER
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar:/usr/local/hadoop-2.6.0/share/hadoop/common/hadoop-common-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/common/hadoop-common-2.6.0-tests.jar:/usr/local/hadoop-2.6.0/share/hadoop/common/hadoop-nfs-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/hdfs/hadoop-hdfs-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/hdfs/hadoop-hdfs-2.6.0-tests.jar:/usr/local/hadoop-2.6.0/share/hadoop/hdfs/hadoop-hdfs-nfs-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-app-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-hs-plugins-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-2.6.0-tests.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-client-shuffle-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-api-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-applications-distributedshell-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-applications-unmanaged-am-launcher-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-client-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-common-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-server-applicationhistoryservice-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-server-common-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-server-nodemanager-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-server-resourcemanager-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-server-tests-2.6.0.jar:/usr/local/hadoop-2.6.0/share/hadoop/yarn/hadoop-yarn-server-web-proxy-2.6.0.jar

