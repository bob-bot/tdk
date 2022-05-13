#!/bin/sh

echo "Downloading Steampipe CLI"
curl -fsSL https://raw.githubusercontent.com/turbot/steampipe/main/install.sh
echo "Installing your first plugin, AWS"
steampipe plugin install aws
echo "Installing the AWS Compliance Mod"
git clone https://github.com/turbot/steampipe-mod-aws-compliance
cd steampipe-mod-aws-compliance
echo "Steampipe CLI, AWS Plugin & AWS Compliance Mod are installed"
echo "More info on AWS Compliance Mod: https://hub.steampipe.io/mods/turbot/aws_compliance"
echo "Copy one of the commands to run your 1st benchmark:"
echo "steampipe check aws_compliance.benchmark.audit_manager_control_tower"
echo "steampipe check aws_compliance.benchmark.cis_v130"
echo "steampipe check aws_compliance.benchmark.cis_v140"
echo "steampipe check aws_compliance.benchmark.foundational_security"
echo "steampipe check aws_compliance.benchmark.gdpr"
echo "steampipe check aws_compliance.benchmark.hipaa"
echo "steampipe check aws_compliance.benchmark.nist_800_53_rev_4"
echo "steampipe check aws_compliance.benchmark.nist_csf"
echo "steampipe check aws_compliance.benchmark.pci_v321"
echo "steampipe check aws_compliance.benchmark.rbi_cyber_security"
echo "steampipe check aws_compliance.benchmark.soc_2"