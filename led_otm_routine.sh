#!/bin/bash

cd /mnt/ide0/home/cmaene/data/LED_OTM
today=`date +"%m%d%y"`
echo $today

# ---------------------------------------------------------
# R - run LEHD_LODES72_bulkDownload.R
# ---------------------------------------------------------
# download LODES Version 7.1 data from Census Bureau

# ---------------------------------------------------------
# Bash - extract all compressed file within "Version72" directory
# ---------------------------------------------------------
# gunzip - is a bit rough tool, but..
# it will replace all files with name ends with .z or.Z (like my .gz files)
# -r Recurse: uncompress all files within the directory
# -k : keep the original file
# gunzip -rvk Version72

gunzip -rv Version72

# ---------------------------------------------------------
# Bash - reorganize files as follows
# ---------------------------------------------------------
# files were organized as follows because of irregular data availabilities by states
# i.e. keep organizing data files by state doesn't make much sense
# RAC -- JT00 -- 2002-2014 (yearly folder, containing all "_rac_" & "20xx.csv" files)
# WAC -- JT00 -- 2002-2014 (yearly folder, containing all "_rac_" & "20xx.csv" files)
# file name example: ak_rac_S000_JT00_2002.csv

mkdir /mnt/ide0/home/cmaene/data/LED_OTM/Version72wksp
cd /mnt/ide0/home/cmaene/data/LED_OTM/Version72wksp
mkdir RAC
cd RAC
mkdir JT00
cd JT00
for i in {2002..2014};do
    mkdir $i
done

cd /mnt/ide0/home/cmaene/data/LED_OTM/Version72wksp
mkdir WAC
cd WAC
mkdir JT00
cd JT00
for i in {2002..2014};do
    mkdir $i
done

cd /mnt/ide0/home/cmaene/data/LED_OTM/Version72
for i in {2002..2014};do
    find -name '*_rac_S000_JT00_'$i'.csv' -exec cp -t /mnt/ide0/home/cmaene/data/LED_OTM/Version72wksp/RAC/JT00/$i {} +
    find -name '*_wac_S000_JT00_'$i'.csv' -exec cp -t /mnt/ide0/home/cmaene/data/LED_OTM/Version72wksp/WAC/JT00/$i {} +
done

# ---------------------------------------------------------
# Stata - finally format the data files
# ---------------------------------------------------------
# run crledrac0214.do - pre-process files to create annual data files
# run crledwac0214.do - pre-process files to create annual data files
# run crledracwac0214_mergeall.do - aggregate/collapse and merge all by tract & county
# final 4 outputs (tract/county for RAC/WAC): tract10code_led0214.dta, county10code_led0214.dta

# ---------------------------------------------------------
# Stata - clip for 2011-2014 only, what Prof. Allard asked for 
# ---------------------------------------------------------
# run ProfAllard_clip2011-14.do

