select ar.Name, al.Title [Album Title]
from artist ar
	inner join Album al 
		on ar.ArtistId = al.ArtistId

select ar.Name, al.Title [Album Title]
from artist ar 
	left join Album al 
		on ar.ArtistId = al.ArtistId

where al.AlbumId is null

select ar.Name, al.Title [Album Title]
from artist ar
	right join Album al 
		on ar.ArtistId = al.ArtistId


where ar.Name = 'Ac/DC'
--where Name like 'b%'
--where ArtistId > 12

select *
from Album
where ArtistId = 169




--select Top 1 BillingCountry, sum(Total) as InvoiceTotal, count(1) as CountOfInvoices
select BillingCountry, sum(Total) as InvoiceTotal, count(1) as CountOfInvoices, AVG(total), max(Total), min(total)
from Invoice
group by BillingCountry
order by InvoiceTotal desc --asc

select sum(total), count(1), STRING_AGG(BillingCountry,',')
from Invoice




--where Year(InvoiceDate) = 2009
--where InvoiceDate between '1/1/2009' and '1/1/2010'


--Subquery
select CustomerId, sum(total)
from Invoice
where CustomerId in (
						select CustomerId
						from Customer 
						where Company is not null
					)
group by CustomerId


select i.CustomerId, sum(total)
from Invoice i
	join (
			select CustomerId
			from Customer 
			where Company is not null
	     ) c
		on i.CustomerId = c.CustomerId
group by i.CustomerId


--correlated subquery
select e.FirstName + ' ' + e.LastName as Name, 
	   E.EmployeeId,
	   e.City, 
	   (
	    select string_agg(FirstName + ' ' + LastName,',') 
		from Customer 
		where SupportRepId = e.EmployeeId
	   ) as Customers
from Employee e

select * 
from Employee e
where exists (
			  select 0 
			  from Customer c 
			  where c.SupportRepId = e.EmployeeId
			 )

select distinct e.* 
from Employee e
	join Customer c 
		on c.SupportRepId = e.EmployeeId



--multiple datasets
--union (distinct), union all
select firstname, lastname, 'Customer' Type
from Customer
union
select firstname, lastname, 'Employee' Type
from Employee
--union all
except
select 'Andrew', 'Adams', 'Employee'
order by type, LastName


--except removes data that matches a set
--all employees that don't work hard.
select * 
from Employee
except
select distinct e.* 
from Employee e
	join Customer c 
		on c.SupportRepId = e.EmployeeId 
