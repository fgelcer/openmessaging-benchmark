/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.openmessaging.benchmark.driver.jms.config;

import java.util.ArrayList;
import java.util.List;

public class JMSConfig
{
    public String connectionFactoryClassName = "<PLEASE SET A VALUE>";

    public String connectionFactoryConfigurationParam = "";

    public String topicNamePrefix = "";

    public String messageSelector;

    public List<AddSelectors> messageSelectors = new ArrayList<>();

    public List<AddProperty> properties = new ArrayList<>();

    public boolean use20api;

    /**
     * Print a error on the log (of the worker) in case of duplicate message
     */
    public boolean errorOnRedelivered = true;

    public DestinationType destinationType = DestinationType.Topic;

    public ConsumerType consumerType = ConsumerType.SharedDurableConsumer;

    public boolean sendWithTransactions = false;

    public String delegateForAdminOperationsClassName;

    public static class AddProperty {
        public String name = "";
        public String value = "";
        public int every = 0;
        public int of = 0;
    }

    public static class AddSelectors {
        public String selector;
    }

    public enum ConsumerType {
        SharedDurableConsumer,
        Consumer,
        DurableSubscriber
    }

    public enum DestinationType {
        Topic,
        Queue
    }
}
