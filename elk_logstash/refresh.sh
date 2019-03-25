#!/bin/bash

neuprint_length=`wc -l /groups/flyem/data/elk_logstash/logs/neuprint.json | awk '{print $1}'`
cp /groups/flyem/data/proofreading_logs/neuprintlog-emdata1\:11000.json /groups/flyem/data/elk_logstash/logs/neuprint.json
neuprint_new=`wc -l /groups/flyem/data/elk_logstash/logs/neuprint.json | awk '{print $1}'`

assignmentc_length=`wc -l /groups/flyem/data/elk_logstash/logs/mad_assignments_completed.json | awk '{print $1}'`
assignments_length=`wc -l /groups/flyem/data/elk_logstash/logs/mad_assignments_started.json | awk '{print $1}'`
cp /groups/scicomp/informatics/logs/* /groups/flyem/data/elk_logstash/logs 
assignmentc_new=`wc -l /groups/flyem/data/elk_logstash/logs/mad_assignments_completed.json | awk '{print $1}'`
assignments_new=`wc -l /groups/flyem/data/elk_logstash/logs/mad_assignments_started.json | awk '{print $1}'`

if [ "$assignmentc_new" != "$assignmentc_length" ] && [ "$assignmentc_new" != 0 ]; then
    echo "Loading MAD assignment completions ($assignmentc_new != $assignmentc_length)"
    curl -XDELETE http://flyem-elk.int.janelia.org:9200/mad_assignment_completed_index
    /bin/rm -rf /tmp/logstash_mad_assignment_completed
    /usr/share/logstash/bin/logstash --path.data /tmp/logstash_mad_assignment_completed -f /groups/flyem/data/elk_logstash/mad_assignment_completed_stdin.conf </groups/flyem/data/elk_logstash/logs/mad_assignments_completed.json
fi
if [ "$assignments_new" != "$assignments_length" ] && [ "$assignments_new" != 0 ]; then
    echo "Loading MAD assignment starts ($assignments_new != $assignments_length)"
    curl -XDELETE http://flyem-elk.int.janelia.org:9200/mad_assignment_started_index
    /bin/rm -rf /tmp/logstash_mad_assignment_started
    /usr/share/logstash/bin/logstash --path.data /tmp/logstash_mad_assignment_started -f /groups/flyem/data/elk_logstash/mad_assignment_started_stdin.conf </groups/flyem/data/elk_logstash/logs/mad_assignments_started.json
fi

if [ "$neuprint_new" != "$neuprint_length" ] && [ "$neuprint_new" != 0 ]; then
    echo "Loading NeuPrint ($neuprint_new != $neuprint_length)"
    curl -XDELETE http://flyem-elk.int.janelia.org:9200/neuprint_index
    /bin/rm -rf /tmp/logstash_neuprint
    /usr/share/logstash/bin/logstash --path.data /tmp/logstash_neuprint -f /groups/flyem/data/elk_logstash/neuprint_stdin.conf </groups/flyem/data/elk_logstash/logs/neuprint.json
fi
