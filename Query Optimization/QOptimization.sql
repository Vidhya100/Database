
	Query Optimization-

	What doe query do? 
		
		What is its purpose?
		What should the result set look like?
		what sort of code, report or UI generating the query?


	How to undertansd the query?
		
		How large is the result set?
		Are there any parameters that have limited values?
		how often is the query executed?
		Are there any invalid or unusual input values that are indicative of an application problem?
		Are there any obvious logical, syntactical or optimization problem staring us in the face?
		What is acceptable query performance?


	Tools
		Execution Plans
			It provides a graphical representation of how the query optimizer chose to execute a query.
			Shows us - which tables were accessed,
					   how they were accessed,
					   how they were joined together
					   any other operation that occured along the way.

			Statistics IO
					Allow us to see how many logical and physical reads are made when a query executed and may be turned on interactively in QL Sever Management studio by running the TSQL:
						SET STATISTICS IO ON;
			Query Duration
				The time it takes a query to execute is going to often be the smoking gun that leads to a performance problem in need of a solution.
			Our eye

	What does the query optimizer do?
		Paring-
				Parsing is the process by which query syntax is checked.
				 Are keywords valid and are the rules of the TSQL language being followed correctly.
		Binding-
				Binding checks all objects referenced in your TQL against the system catalogs and any temporary objects defined within your code to determine if they are both valid and referenced correctly.
				Information about these objects is retrieved, such as data types, constraints, and if a column allows NULL or not. 
		Optimization-
				 The optimizer operates similarly to a chess (or any gaming) computer.
				  It needs to consider an immense number of possible moves as quickly as possible, remove the poor choices, and finish with the best possible move
		Execution - 
				Execution is the final step. SQL Server takes the execution plan that was identified in the optimization step and follows those instructions in order to execute the query.

		
		Coomon Themes in QOP -
			Index scan
			Functions wrapped around joins and where clauses
			Implicit Conversions.
			

	Top 10 techniques -
		
			#1 Define the requirements
			#2 SELECT fields, rather than using SELECT *
			#3 Avoid DISTINCT in SELECT query -
				SELECT DISTINCT is a simple way of removing duplicates from a database. SELECT DISTINCT works to generate distinct outcomes by using the GROUP BY clause, which groups all the fields in the query. However, a large amount of processing power is required to do this. So, avoid DISTINCT in SELECT queries.
			#4 Indexing -
					Indexing in SQL Server helps retrieve data more quickly from a table, thereby giving a tremendous boost to SQL query performance. Allow effective use of clustered and non-clustered indexes
		#5 To check the existence of records, use EXISTS() rather than COUNT()-
					The EXISTS() method is more effective as it exits processing as soon as it finds the first entry of the record in the table.
					The COUNT() method would scan the entire table to return the number of records in the table that match the provided constraint.
		#6 Limit your working data set size
		#7 Use WHERE instead of HAVING
		#8 Ignore linked subqueries
					A linked subquery depends on the query from the parent or from an external source. It runs row by row, so the average cycle speed is greatly affected.
		#9 Use of temp table
		#10 Don’t run queries in a loop