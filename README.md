# Comprehensive project flow

#### Data-ს სტატიის ბმული - https://bmcgenomics.biomedcentral.com/track/pdf/10.1186/1471-2164-14-612.pdf

## SETUP:

1) შევქმენი Miniconda-ს გარემო
    1.1) conda version 4.13.0
    1.2) conda config --add channels defaults
         conda config --add channels bioconda
         conda config --set channel_priority strict
3) პირველ რიგში, გადმოვწერე sra-tools(v3.0.0) data-ს გადმოსაწერად.
    3.1) კონდადან ვერ დავაყენე ამიტომ პირდაპირ გადმოვწერე "საინსტალაციო".
    3.2) ყველაფრის ინსტრუქცია არის ამ ლინკზე https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit
4) მოვძებნე data.
    4.1) "The sequencing data have been deposited in NCBI Sequence Read Archive (SRA, http://www.ncbi.nlm.nih.gov/Traces/sra) and the accession number is SRA062881"
    4.2) NCBI-ს SRA ბაზაში მოვძებნე ეს accession number-ი.
    4.3) პირველივეზე გადავედი, იქიდან გადავედი შემდეგ all runs-ზე. მოვხვდი ამ ლინკზე. https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP017563&o=acc_s%3Aa
    4.4) აქედან ამოვიღე run-ების კოდები. hypo არ ამოვიღე რადგანაც სხვა კვლევისაა.
5) გადმოვწერე data. download.sh სკრიპტით.
    5.1) რადგანაც layout-ში ვხედავთ რომ არის paired გადმოვწერთ ფაილებს სახელებით accession_number_1 და accession_number_2.
    5.2) ასევე "&" ოპერატორით თითოეული ფაილის გადმოწერა გაეშვება ბექგრაუნდში, ცალ-ცალკე პროცესებად, რაც საკმაოდ აასწრაფებს ყველაფერს.
6) ამის შემდეგ უნდა დავიწყოთ RNA-seq workflow
    6.1) თავიდან ვეცადე სტატიაში მოცემულ pipeline-ს გავყოლოდი მოცემული პროგრამების მოცემული ვერსიებით.
    6.2) უმეტესობა გამოყენებული პროგრამული tool-ების სტატიაში ნახსენები ვერსიები არ იშოვებოდა და ამიტომ ზოგი ჩავანაცვლე შედარებით ახალი ვერსიებით, რომლებიც იშოვებოდა.
    6.3) მაგრამ აღმოჩნდა, რომ მოცემული pipeline სიძველესთან ერთად დროისა და მეხსიერების მხრივ საკმაოდ დატვირთული იყო, რასაც ჩემი ლეპტოპი ვერ შესწვდებოდა.
    6.4) ამიტომ ვცადე მონაცემების დამუშავებისთვის ჩემით ამეწყო ახალი pipeline ახალი, შედარებით თანამედროვე პროგრამული tool-ების და ვერსიების გამოყენებით.
    6.5) ჯერ დავწერ ძველ pipeline-ზე სადამდე მივედი და როგორ გავყევი შემდეგ კი ახალ pipeline-ს.

## Old pipeline:

0) conda install python=2.7
1) პირველ რიგში მოდის data preprocessing ნაწილი, რომელიც სტატიაში მოიცემა trimming and filtering PRINSEQ სახით
    1.1) ვერსია, რომელიც სტატიაშია მითითებული არ იყო კონდაზე, მხოლოდ უახლესი ვერსია იყო და ამიტომ მაგის დაყენება მომიწია.
        conda install prinseq, დაყენდა 0.20.4 ვერსია
    1.2) "The raw reads were trimmed and filtered using PRINSEQ (version 0.19.3) [74]. Low quality (Q < 20) and ambiguous bases (N) were first trimmed from both ends of the reads and the trimmed reads were filtered with Phred quality score (Q ≥ 20 for all bases) and read length (≥ 25 bp)."
    1.3) "trimmed reads were filtered with Phred quality score (Q ≥ 20 for all bases) and read length (≥ 25 bp)"
    1.4) preprocess_prinseq.sh ფაილში მოცემულია სკრიპტი, რომელიც სტატიაში ნათქვამი კონფიგურაციების მიხედვით გააკეთებს data preprocessing-ს.
2) დაწყვილებული read-ების ამოსაღებად და singleton-ების მოსაშორებლად სტატიაში ნახსენები tool-ი cmpfastq საერთოდ არ იშოვებოდა, ამიტომ ეს ნაბიჯი გამოვტოვე.
3) შემდეგი ნაწილი არის ზებრათევზის რეფერენს გენომის გადმოწერა და ინდექსაცია
    3.1) ზებრათევზის რეფერენს გენომი გადმოვწერე ამ ლინკიდან http://ftp.ensembl.org/pub/release-107/fasta/danio_rerio/dna/
    3.2) ამ ლინკზე მოცემული გენომებიდან ჩვენთვის საჭირო ანალიზისთვის მოვიძიე, რომ ყველაზე გამოსადეგი არის dna_rm.primary_assemble ვერსია
    3.3) გადმოწერის შემდეგ დავაყენე tophat. სტატიის ვერსია ისევ მიუწვდომელი იყო და ამიტომ 2.0.13 ვერსია დავაყენე.
    3.4) ამის შემდეგ გავუშვი რეფერენს გენომის ინდექსაცია bowtie2-ის(რომელიც tophat-ს მოყვა) გამოყენებით.
    3.5) ინდექსაციის სკრიპტი შეგიძლიათ იხილოთ bowtie_index.sh ფაილში.
4) ამის შემდეგი ნაწილი არის უკვე genome mapping-ი tophat-ის გამოყენებით.
    4.1) tophat-ის სკრიპტი შეგიძლიათ იხილოთ runtophat.sh ფაილში.
    4.2) როგორც აღმოჩნდა tophat უკვე ზედმეტად ბევრ დროს და რესურსს მოითხოვდა, ამიტომ ძველი pipeline-ის ამ ნაბიჯზე შეჩერება მომიწია.

ძველი pipeline: fastq-dump -> prinseq -> cmpfastq -> bowtie -> tophat -> cufflinks -> cuffmerge -> cuffdiff

## New pipeline:

0) conda install python=3.7 (შემდგომში downgrade დამჭირდა 3.6-მდე, ნაბიჯი 6.4)
1) პირველი ნაწილი არის data preprocessing.
    1.1) ამისთვის გამოვიყენე უფრო სწრაფი და თანამერდროვე tool-ი სახელად fastp.
    1.2) conda install fastp, ვერსია დაყენდა 0.23.2
    1.3) preprocess_fastp.sh ფაილში შეგიძლიათ იხილოთ სკრიპტი და კონფიგურაციები.
    1.4) ასევე, additional_info/preprocess_cmp ფაილში შეგიძლიათ იხილოთ შედარება fastp-სა და prinseq-ის ფილტრების კონსოლის აუთფუთს შორის.
    1.5) fastp-ს დამატებითი აუთფუთი არის additional_info/fastp.html და additional_info/fastp.json ფაილებში.
2) დაწყვილებული read-ების ამოსაღებად cmpfastq-ს ჩანაცვლება არ გახდა საჭირო, რადგანაც fastp ითვალისწინებს უკვე მაგ ნაბიჯს თავის თავში.
    2.1) მაგრამ ყოველი შემთხვევისთვის ამ ნაბიჯისთვის დასაზღვევად და data-ს გასაუმჯობესებლად გამოვიყენე bbmap-ის repair ფუნქცია.
    2.2) conda install bbmap, დაყენდა ვერსია 38.96.
    2.3) re_pair.sh ფაილში არის repair tool-ის გაშვების სკრიპტი.
3) შემდეგი ნაბიჯი არის ზებრათევზის რეფერენს გენომის გადმოწერა და ინდექსაცია
    3.1) ზებრათევზის რეფერენს გენომი იმავენაირად გადმოვწერე ზუსტად. ამ ლინკიდან http://ftp.ensembl.org/pub/release-107/fasta/danio_rerio/dna/
    3.2) ამ ლინკზე მოცემული გენომებიდან ისევ ავიღე dna_rm.primary_assemble ვერსია
    3.3) tophat-ს უწერია რომ იგი ჩანაცვლდა ჯერ tophat2-ით, შემდეგ hisat-ით და ბოლოს hisat2-ით. ამიტომ გადავწყვიტე genome mapping-ისთვის HISAT2 გამომეყენებინა.
    3.4) ამისთვის დავაინსტალირე hisat2. conda install hisat2. დაყენდა 2.2.1 ვერსია.
    3.5) ინდექსის ასაგებად გამოვიყენე hisat2-build ბრძანება.
    3.6) hisat_index.sh ფაილში მოცემულია ამის სკრიპტი.
4) შუალედური ნაბიჯი genome mapping-ის გაშვებამდე. 
    4.1) hisat2-ის genome mapping შეგვეძლო უკვე გაგვეშვა, მაგრამ არსებობს გზები ამ პროცესის გაუმჯობესებისა. ამიტომ მანამდე შემდეგი მანიპულაციები ჩავატარე.
    4.2) hisat2-ის შემდეგ უნდა მოხდეს მისი შედეგის transcript assembly. ამისთვის გადავწყვიტე გამომეყენებინა tool-ი სახელად StringTie, რომელიც ძველი pipeline-დან Cufflinks-ის ჩამანაცვლებელი იქნება.
    4.3) StringTie-ის დოკუმენტაციაში ვკითხულობთ, რომ განსაკუთრებით რეკომენდირებულია hisat2 გავუშვათ --dta კონფიგურაციით და ასევე მივაწოდოთ splice site-ების უკვე არსებული ინფორმაცია რეფერენს გენომის ანოტაციიდან.
    4.4) ამისათვის ჯერ უნდა გადმოვწეროთ რეფერენს გენომის ანოტაცია. იგი(Danio_rerio.GRCz11.107.gtf.gz) გადმოვწერე შემდეგი ლინკიდან - http://ftp.ensembl.org/pub/release-107/gtf/danio_rerio/
    4.5) რეფერენს გენომის ანოტაციიდან splice site-ების ამოსაღები tool-ი მოყვება hisat2-ს.
    4.6) splice site-ების ამოღების სკრიპტი შეგიძლიათ იხილოთ extract_splice_sites.sh
5) ამის შემდეგ უკვე დროა გადავიდეთ genome mapping ნაწილზე, სადაც წინა pipeline-ის მიტოვება მომიწია.
    5.1) HISAT-ის გაშვების სკრიპტი შეგიძლიათ იხილოთ runhisat.sh ფაილში.
    5.2) HISAT-ი გაცილებით სწრაფი აღმოჩნდა Tophat-თან შედარებით და არცერთ ფაილზე 15 წუთზე მეტი არ დასჭრივებია.
    5.3) HISAT-ის კონსოლში დაბეჭდილი მონაცემები შეგიძლიათ იხილოთ additional_info/hisat_console_output.txt ფაილში.
6) genome mapping შედეგის დამუშავება.
    6.1) პირველ რიგში, შედეგები გაანალიზებადი რომ გახდეს, ყველა ანალიზის tool მოითხოვს ეს შედეგები იყოს დალაგებული(და-sort-ილი).
    6.2) ამისათვის ბიოინფორმატიკაში ალბათ ყველაზე პოპულარული tool-ი სახელად samtools.
    6.3) conda install samtools, დაყენდა ვერსია 1.6.
    6.4) დალაგების სკრიპტი შეგიძლიათ იხილოთ sortoutput.sh ფაილში.
    6.5) დალაგების შემდეგ გადავწყვიტე genome mapping-ის შედეგების quality-ის შეფასება მომეხდინა.
    6.6) ამისათვის გამოვიყენე tool-ი სახელად picard. რომელიც სხვადასხვა მონაცემებს ზომავს genome mapping შედეგებისთვის.
    6.7) conda install picard, დაყენდა ვერსია 2.18.29.
    6.8) picard-ის გაშვების სკრიპტი შეგიძლიათ იხილოთ runpicard.sh ფაილში.
    6.9) აქვე დავაკვირდი, რომ picard-ის მიერ .txt ფაილში ცხრილში ჩაწერილი მონაცემები ძალიან რთული გასარჩევი იყო ადამიანის თვალისთვის. ამიტომ დავწერე ჩემი პითონის კოდი, რომელიც .txt ფაილში აცდენილ ცხრილებს ალამაზებს და ადამიანის თვალისთვის წაკითხვადს ხდის.
    6.10) ეს კოდი არის beautify_tablefiles.py და იგი გამოყენებულია runpicard.sh სკრიპტში.
7) ამის შემდეგ უკვე მოდის genome mapping-ის შედეგებიდან transcript assembly. 
    7.1) ამისათვის, როგორც ზემოთ ვახსენე, გამოვიყენე StringTie.
    7.2) conda install stringtie. დაყენდა 2.2.1 ვერსია.
    7.3) სანამ StringTie-ზე გადავალ, უნდა ვახსენო, რომ ამ მომენტში ვცადე ძველ pipeline-ზე დაბრუნება და cufflinks-ის გამოყენება.
    7.4) cufflinks-ის დასაყენებლად დამჭირდა პითონის downgrade. ამიტომ გავუშვი შემდეგი ბრძანებები. conda install python=3.6. conda install cufflinks. დაყენდა 2.2.1 ვერსია.
    7.5) cufflinks-ს ყველაზე პატარა ფაილზე დასჭირდა დაახლოებით 11 საათი. ამიტომ cufflinks-ის იდეა მივატოვე. cufflinks-ის გაშვების სკრიპტი არის runcufflinks.sh ფაილში.
    7.6) StringTie-ს ერთ ფაილზე 5 წუთზე მეტი არ დასჭირვებია.
    7.7) StringTie-ს გაშვების სკრიპტი შეგიძლიათ იხილოთ runstringtie.sh ფაილში.
8) სანამ differential expression analysis-მდე მივალთ დარჩა ერთი ნაბიჯი, რაც წინა ნაბიჯის შედეგების შეერთებაა.
    8.1) წინა pipeline-ში ამისათვის cuffmerge-ს იყენებდნენ. მე stringtie --merge ბრძანებას გამოვიყენებთ.
    8.2) ამის სკრიპტი შეგიძლიათ იხილოთ merge_stringtie_output.sh ფაილში.
9) ბოლო ნაბიჯი არის უკვე differential expression analysis.
    9.1) StringTie-ის დოკუმენტაციაში რეკომენდაციია გამოვიყენოთ Ballgown.
    9.2) რათა data გავამზადოთ Ballgown-ისთვის გამოსაყენებლად უნდა შევქმნათ coverage table-ბი, რომლებსაც Ballgown იყენებს სხვადასხვა ანალიზის ჩასატარებლად.
    9.3) coverage table-ბის დაგენერერირება შეუძლია StringTie-ს და ამის სკრიპტი არის generate_coverage_table.sh ფაილში.
    9.4) ასევე მინდოდა differential expression analysis-ისთვის გამომეყენებინა ძველი pipeline-დან cuffdiff. რადგანაც StringTie-ის დოკუმენტაციაში ეწერა რომ StringTie-ის output მორგებადი იყო Cuffdiff-ზეც.
    9.5) Cuffdiff-ის გასაშვები სკრიპტი არის runcuffdiff.sh ფაილში. Cuffdiff მოჰყვა Cufflinks package-ს.

საბოლოო pipeline:

![PipelineImage](https://drive.google.com/uc?export=view&id=1S4V9yAodWMFKZDP8zJpW2g2F91P9VdEV)

## ანალიზი

1) Cuffdiff-ის ანალიზი გრძელდება jupyter notebook-ში. Analysis.ipynb
    1.1) conda install jupyter
2) jupyter notebookისთვის მომიწია შემდეგი ბიბლიოთეკების დაინსტალირება
    2.1) conda install pandas
    2.2) conda install seaborn
    

## დამატებითი ინფორმაცია

1) environment-ზე ინფორმაცია
    1.1) მთლიანი environment-ის yaml ფაილი დავაექსტრაქტე conda env export > zebrafish.yaml ბრძანებით.
    1.2) შეგიძლიათ package-ბის ცალ-ცალკე დაყენების ნაცვლად conda env create -f zebrafish.yaml ფაილით შექმნათ გარემო.

2) დამატებითი ინფორმაცია
    2.1) დიდი ფაილები(> 100MB) არ არის გითჰაბის რეპოზიტორიაში. პატარა ფაილები პირდაპირაა მოცემული.
    2.2) გითჰაბის რეპოზიტორია 120MB-მდე არის ზომაში. 

3) წყაროები და გამოსადეგი ბმულები:
    3.1) quality check-ზე დამატებითი ინფორმაცია: https://www.biobam.com/quality-check-and-preprocessing-how-to-perform-them-with-blast2go/?cn-reloaded=1

    3.2) aligner-ების შედარება:
        12.2.1) https://www.frontiersin.org/articles/10.3389/fpls.2021.657240/full
        12.2.2) https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7084517/

    3.3) რომელი რეფერენს გენომის ფაილი უნდა გადმოვწერო https://bioinformatics.stackexchange.com/questions/540/what-ensembl-genome-version-should-i-use-for-alignments-e-g-toplevel-fa-vs-p

    3.4) StringTie-ს ნაშრომი https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1910-1

    3.5) RNA-seq-ის workflow-ზე ინფორმაცია. https://www.ebi.ac.uk/training/online/courses/functional-genomics-ii-common-technologies-and-data-analysis-methods/rna-sequencing/

    3.6) RNA-seq-ის workflow-ზე ინფორმაცია. https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-0881-8

    3.7) სხვადასხვა pipeline-ბის შედარება. https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-022-08465-0

    3.8) ყველა ნახსენები tool-ის დოკუმენტაცია, რომლებიც ძალიან დიდ ინფორმაციას შეიცავს, არამარტო ამ tool-ებზე.

    3.9) და სხვა მრავალი რომელთა ბმულებიც არ შემინახავს...
