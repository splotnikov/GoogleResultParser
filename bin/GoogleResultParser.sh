#!/bin/sh
# ----------------------------------------------------------------------------
#  Copyright 2001-2006 The Apache Software Foundation.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#
#   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
#   reserved.


# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`
BASEDIR=`cd "$PRGDIR/.." >/dev/null; pwd`

# Reset the REPO variable. If you need to influence this use the environment setup file.
REPO=


# OS specific support.  $var _must_ be set to either true or false.
cygwin=false;
darwin=false;
case "`uname`" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true
           if [ -z "$JAVA_VERSION" ] ; then
             JAVA_VERSION="CurrentJDK"
           else
             echo "Using Java version: $JAVA_VERSION"
           fi
		   if [ -z "$JAVA_HOME" ]; then
		      if [ -x "/usr/libexec/java_home" ]; then
			      JAVA_HOME=`/usr/libexec/java_home`
			  else
			      JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/${JAVA_VERSION}/Home
			  fi
           fi       
           ;;
esac

if [ -z "$JAVA_HOME" ] ; then
  if [ -r /etc/gentoo-release ] ; then
    JAVA_HOME=`java-config --jre-home`
  fi
fi

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
  [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --unix "$CLASSPATH"`
fi

# If a specific java binary isn't specified search for the standard 'java' binary
if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      # IBM's JDK on AIX uses strange locations for the executables
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD=`which java`
  fi
fi

if [ ! -x "$JAVACMD" ] ; then
  echo "Error: JAVA_HOME is not defined correctly." 1>&2
  echo "  We cannot execute $JAVACMD" 1>&2
  exit 1
fi

if [ -z "$REPO" ]
then
  REPO="$BASEDIR"/repo
fi

CLASSPATH="$BASEDIR"/etc:"$REPO"/org/seleniumhq/selenium/selenium-java/2.45.0/selenium-java-2.45.0.jar:"$REPO"/org/seleniumhq/selenium/selenium-chrome-driver/2.45.0/selenium-chrome-driver-2.45.0.jar:"$REPO"/org/seleniumhq/selenium/selenium-remote-driver/2.45.0/selenium-remote-driver-2.45.0.jar:"$REPO"/cglib/cglib-nodep/2.1_3/cglib-nodep-2.1_3.jar:"$REPO"/com/google/code/gson/gson/2.3.1/gson-2.3.1.jar:"$REPO"/org/seleniumhq/selenium/selenium-api/2.45.0/selenium-api-2.45.0.jar:"$REPO"/com/google/guava/guava/18.0/guava-18.0.jar:"$REPO"/org/seleniumhq/selenium/selenium-htmlunit-driver/2.45.0/selenium-htmlunit-driver-2.45.0.jar:"$REPO"/net/sourceforge/htmlunit/htmlunit/2.15/htmlunit-2.15.jar:"$REPO"/xalan/xalan/2.7.1/xalan-2.7.1.jar:"$REPO"/xalan/serializer/2.7.1/serializer-2.7.1.jar:"$REPO"/commons-collections/commons-collections/3.2.1/commons-collections-3.2.1.jar:"$REPO"/org/apache/commons/commons-lang3/3.3.2/commons-lang3-3.3.2.jar:"$REPO"/org/apache/httpcomponents/httpmime/4.3.3/httpmime-4.3.3.jar:"$REPO"/commons-codec/commons-codec/1.9/commons-codec-1.9.jar:"$REPO"/net/sourceforge/htmlunit/htmlunit-core-js/2.15/htmlunit-core-js-2.15.jar:"$REPO"/xerces/xercesImpl/2.11.0/xercesImpl-2.11.0.jar:"$REPO"/xml-apis/xml-apis/1.4.01/xml-apis-1.4.01.jar:"$REPO"/net/sourceforge/nekohtml/nekohtml/1.9.21/nekohtml-1.9.21.jar:"$REPO"/net/sourceforge/cssparser/cssparser/0.9.14/cssparser-0.9.14.jar:"$REPO"/org/w3c/css/sac/1.3/sac-1.3.jar:"$REPO"/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar:"$REPO"/org/eclipse/jetty/jetty-websocket/8.1.15.v20140411/jetty-websocket-8.1.15.v20140411.jar:"$REPO"/org/eclipse/jetty/jetty-util/8.1.15.v20140411/jetty-util-8.1.15.v20140411.jar:"$REPO"/org/eclipse/jetty/jetty-io/8.1.15.v20140411/jetty-io-8.1.15.v20140411.jar:"$REPO"/org/eclipse/jetty/jetty-http/8.1.15.v20140411/jetty-http-8.1.15.v20140411.jar:"$REPO"/org/apache/httpcomponents/httpclient/4.3.6/httpclient-4.3.6.jar:"$REPO"/org/apache/httpcomponents/httpcore/4.3.3/httpcore-4.3.3.jar:"$REPO"/org/seleniumhq/selenium/selenium-firefox-driver/2.45.0/selenium-firefox-driver-2.45.0.jar:"$REPO"/commons-io/commons-io/2.4/commons-io-2.4.jar:"$REPO"/org/apache/commons/commons-exec/1.1/commons-exec-1.1.jar:"$REPO"/org/seleniumhq/selenium/selenium-ie-driver/2.45.0/selenium-ie-driver-2.45.0.jar:"$REPO"/net/java/dev/jna/jna/3.4.0/jna-3.4.0.jar:"$REPO"/net/java/dev/jna/platform/3.4.0/platform-3.4.0.jar:"$REPO"/org/seleniumhq/selenium/selenium-safari-driver/2.45.0/selenium-safari-driver-2.45.0.jar:"$REPO"/org/seleniumhq/selenium/selenium-support/2.45.0/selenium-support-2.45.0.jar:"$REPO"/org/webbitserver/webbit/0.4.14/webbit-0.4.14.jar:"$REPO"/io/netty/netty/3.5.2.Final/netty-3.5.2.Final.jar:"$REPO"/org/seleniumhq/selenium/selenium-leg-rc/2.45.0/selenium-leg-rc-2.45.0.jar:"$REPO"/com/googleparser/googleresultparser/1.0/googleresultparser-1.0.jar

ENDORSED_DIR=
if [ -n "$ENDORSED_DIR" ] ; then
  CLASSPATH=$BASEDIR/$ENDORSED_DIR/*:$CLASSPATH
fi

if [ -n "$CLASSPATH_PREFIX" ] ; then
  CLASSPATH=$CLASSPATH_PREFIX:$CLASSPATH
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin; then
  [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --path --windows "$JAVA_HOME"`
  [ -n "$HOME" ] && HOME=`cygpath --path --windows "$HOME"`
  [ -n "$BASEDIR" ] && BASEDIR=`cygpath --path --windows "$BASEDIR"`
  [ -n "$REPO" ] && REPO=`cygpath --path --windows "$REPO"`
fi

exec "$JAVACMD" $JAVA_OPTS  \
  -classpath "$CLASSPATH" \
  -Dapp.name="GoogleResultParser" \
  -Dapp.pid="$$" \
  -Dapp.repo="$REPO" \
  -Dapp.home="$BASEDIR" \
  -Dbasedir="$BASEDIR" \
  com.googleresultparser.Main \
  "$@"
