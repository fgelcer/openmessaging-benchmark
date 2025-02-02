#!/bin/sh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

# NOTE: this script is intentionally not executable. It is only meant to be sourced for environment variables.

# Set JAVA_HOME here to override the environment setting
# JAVA_HOME=

# default settings for starting bookkeeper

# Configuration file of settings used in bookie server
BOOKIE_CONF=${BOOKIE_CONF:-"$BK_HOME/conf/bookkeeper.conf"}

# Log4j configuration file
# BOOKIE_LOG_CONF=

# Logs location
# BOOKIE_LOG_DIR=

# Memory size options
BOOKIE_MEM=" -Xms{{ max_heap_memory }} -Xmx{{ max_heap_memory }} -XX:MaxDirectMemorySize={{ max_direct_memory }}"

# Garbage collection options
BOOKIE_GC=" {{ gc_options }}"

# PULSAR_GC=" -XX:+UnlockExperimentalVMOptions -XX:+UseZGC -XX:+ParallelRefProcEnabled -XX:+AggressiveOpts -XX:+DoEscapeAnalysis -XX:ParallelGCThreads=12 -XX:ConcGCThreads=12 -XX:+DisableExplicitGC"

BOOKIE_GC="${BOOKIE_GC} -XX:+PerfDisableSharedMem -XX:+AlwaysPreTouch -XX:-UseBiasedLocking"

# Log4j CVE-2021-44228
BOOKIE_GC="${BOOKIE_GC} -Dlog4j2.formatMsgNoLookups=true"

IS_JAVA_8=`java -version 2>&1 |grep version|grep '"1\.8'`
# java version has space, use [[ -n $PARAM ]] to judge if variable exists
if [[ -n $IS_JAVA_8 ]]; then
  BOOKIE_GC_LOG=${BOOKIE_GC_LOG:-${PULSAR_GC_LOG:-"-Xloggc:logs/pulsar_bookie_gc_%p.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=20M"}}
else
# After jdk 9, gc log param should config like this. Ignoring version less than jdk 8
  BOOKIE_GC_LOG=${BOOKIE_GC_LOG:-${PULSAR_GC_LOG:-"-Xlog:gc*:logs/pulsar_bookie_gc_%p.log:time,uptime,level,tags:filecount=10,filesize=20M"}}
fi

# Extra options to be passed to the jvm
BOOKIE_EXTRA_OPTS="${BOOKIE_EXTRA_OPTS:-"-Dio.netty.leakDetectionLevel=disabled ${PULSAR_EXTRA_OPTS:-"-Dio.netty.recycler.maxCapacity.default=1000 -Dio.netty.recycler.linkCapacity=1024"}"}"

# Add extra paths to the bookkeeper classpath
# BOOKIE_EXTRA_CLASSPATH=

#Folder where the Bookie server PID file should be stored
#BOOKIE_PID_DIR=

#Wait time before forcefully kill the Bookie server instance, if the stop is not successful
#BOOKIE_STOP_TIMEOUT=

#Entry formatter class to format entries.
#ENTRY_FORMATTER_CLASS=
