#!/bin/bash

rm -rf berks-cookbooks

berks vendor --berksfile Berksfile berks-cookbooks

sudo chef-client -c client.rb -j dna.json

