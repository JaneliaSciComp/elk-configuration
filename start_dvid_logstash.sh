nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_emdata1_8100_dvid_activity -f emdata1_8100_dvid_activity_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_emdata2_7900_dvid_activity -f emdata2_7900_dvid_activity_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_emdata3_8900_dvid_activity -f emdata3_8900_dvid_activity_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_emdata3_8900_mutations -f emdata3_8900_mutations_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_emdata3_8600_dvid_activity -f emdata3_8600_dvid_activity_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_sage_loader_index -f sage_loader_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_flycore_sync_index -f flycore_sync_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_screen_review_index -f screen_review_kafka.conf &
nohup /opt/logstash/bin/logstash --path.data /tmp/logstash_dvidactivity_localgrayscale_index -f dvidactivity_localgrayscale_kafka.conf &