#!/bin/bash

neuprint_length=`wc -l neuprint.json`
scp svirskasr@informatics-prod:/groups/flyem/data/proofreading_logs/neuprintlog-emdata1\:11000.json neuprint.json
neuprint_new=`wc -l neuprint.json`

assignmentc_length=`wc -l mad_assignments_completed.json`
assignments_length=`wc -l mad_assignments_started.json`
scp svirskasr@informatics-prod:/groups/scicomp/informatics/logs/* .
assignmentc_new=`wc -l mad_assignments_completed.json`
assignments_new=`wc -l mad_assignments_started.json`

if [ "$neuprint_new" != "$neuprint_length" ] && [ "$neuprint_new" != 0 ]; then
    echo "Loading NeuPrint"
    curl -XDELETE http://localhost:9200/neuprint_index
    /bin/rm -rf /tmp/logstash_neuprint
    /opt/logstash/bin/logstash --path.data /tmp/logstash_neuprint -f neuprint_stdin.conf <neuprint.json
fi

if [ "$assignmentc_new" != "$assignmentc_length" ] && [ "$assignmentc_new" != 0 ]; then
    echo "Loading MAD assignment completions"
    curl -XDELETE http://localhost:9200/mad_assignment_completed_index
    /bin/rm -rf /tmp/logstash_mad_assignment_completed
    /opt/logstash/bin/logstash --path.data /tmp/logstash_mad_assignment_completed -f mad_assignment_completed_stdin.conf <mad_assignments_completed.json
fi
if [ "$assignments_new" != "$assignments_length" ] && [ "$assignments_new" != 0 ]; then
    echo "Loading MAD assignment starts"
    curl -XDELETE http://localhost:9200/mad_assignment_started_index
    /bin/rm -rf /tmp/logstash_mad_assignment_started
    /opt/logstash/bin/logstash --path.data /tmp/logstash_mad_assignment_started -f mad_assignment_started_stdin.conf <mad_assignments_started.json
fi

#/opt/logstash/bin/logstash --path.data /tmp/logstash_edges -f edges.conf
#/opt/logstash/bin/logstash --path.data /tmp/logstash_false_split -f false_split.conf
