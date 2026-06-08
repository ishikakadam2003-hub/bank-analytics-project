create database bank_project;
use bank_project;
show tables;


select year (issue_d) ,concat(round(sum(loan_amnt)/1000000,2),"M") as loan_amt from finance_data
where year is not null
group by 1
order by 1 asc;
#------------------------------------------------------

SET GLOBAL local_infile = 1;

CREATE TABLE finance_data (
    id INT,
    member_id INT,
    loan_amnt INT,
    funded_amnt INT,
    funded_amnt_inv DECIMAL(15,2),
    term VARCHAR(50),
    int_rate DECIMAL(10,4),
    installment DECIMAL(10,2),
    grade VARCHAR(5),
    sub_grade VARCHAR(5),
    emp_title VARCHAR(255),
    emp_length VARCHAR(50),
    home_ownership VARCHAR(50),
    annual_inc DECIMAL(15,2),
    verification_status VARCHAR(50),
    issue_d VARCHAR(20),             -- Loading as text first to avoid date errors
    loan_status VARCHAR(50),
    pymnt_plan VARCHAR(10),
    `desc` TEXT,                     -- `desc` is a keyword in SQL, so we wrap it in backticks
    purpose VARCHAR(100),
    title VARCHAR(150),
    zip_code VARCHAR(20),
    addr_state VARCHAR(10),
    dti DECIMAL(10,4),
    delinq_2yrs INT,
    earliest_cr_line VARCHAR(20),    -- Loading as text
    inq_last_6mths INT,
    mths_since_last_delinq INT,
    mths_since_last_record INT,
    open_acc INT,
    pub_rec INT,
    revol_bal INT,
    revol_util DECIMAL(10,4),
    total_acc INT,
    initial_list_status VARCHAR(5),
    out_prncp DECIMAL(15,2),
    out_prncp_inv DECIMAL(15,2),
    total_pymnt DECIMAL(15,2),
    total_pymnt_inv DECIMAL(15,2),
    total_rec_prncp DECIMAL(15,2),
    total_rec_int DECIMAL(15,2),
    total_rec_late_fee DECIMAL(15,2),
    recoveries DECIMAL(15,2),
    collection_recovery_fee DECIMAL(15,2),
    last_pymnt_d VARCHAR(20),        -- Loading as text
    last_pymnt_amnt DECIMAL(15,2),
    next_pymnt_d VARCHAR(20),        -- Loading as text
    last_credit_pull_d VARCHAR(20)   -- Loading as text
);
drop table finance_data;
LOAD DATA LOCAL INFILE 'C:/Users/janardhan/Downloads/combined_finance_data1.csv'  -- <-- REPLACE THIS WITH YOUR PATH
INTO TABLE finance_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from finance_data;
select count(*) from finance_data;
#---------------------------year wise loan_amt issue--------------------------------
select year (issue_d) year ,concat(round(sum(loan_amnt)/1000000,0),"M") as loan_amt from finance_data
group by 1
order by 1 asc;

#--------------------------Total_laon_amt_issue--------------------------------------
select concat(round(sum(loan_amnt)/1000000,0),"M") as loan_amt from finance_data;

#-----------------------no of accounts--------------------------------------
select concat(round(count(*)/1000),"K") as number_of_Accounts from finance_data;

#-------------------------------year wise no of accounts------------------------------------
select year(issue_d) year,concat(round(count(*)/1000),"K") as number_of_Accounts from finance_data
group by 1
order by 1 asc;

#----------------------Toatal_Annual_income--------------------------------
select concat(round(sum(annual_inc)/1000000,2),"M") as Annual_income from finance_data;

#--------------------------year wise annual income-------------------------------------
select year(issue_d) year ,concat(round(sum(annual_inc)/1000000,2),"M") as Annual_income from finance_data
group by 1
order by 1 asc;

#------------------------------Toatl_funded_amt ------------------------------------------
select concat(round(sum(funded_amnt)/1000000),"M") funsed_amt from finance_data;

#------------------------------Year wise funded_amt--------------------------
select year(issue_d)year,concat(round(sum(funded_amnt)/1000000),"M") funsed_amt from finance_data
group by 1
order by 1 asc;

#-------------------grade,sub-grade wise revol_bal-----------------------------------
select  grade,count(sub_grade) sub_grade,concat(round(sum(revol_bal)/1000000),"M") revol_bal from finance_data
group by 1;

#---------------------------verification status-------------------------------------
select verification_status,count(verification_status) verification from finance_data
group by 1;

#--------------------------------Total payment----------------------------------------
select concat(round(sum(total_pymnt)/1000000,2),"M") Total_pymt from finance_data;

#-------------------------------------year wise Total payment---------------------------
select year(issue_d) year,concat(round(sum(total_pymnt)/1000000,2),"M") Toatl_pymt from
finance_data
group by 1
order by 1;