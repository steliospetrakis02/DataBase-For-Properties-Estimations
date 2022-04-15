use db122;
drop procedure find_ecode;
GO
create procedure find_ecode
(
@ecode integer ,
@date_Time1 datetime,
@date_Time2 datetime
) as
begin
	set NOCOUNT ON;
	declare @estcode varchar(100)
	declare @pcode char(100) 
	declare @padress varchar(20)
	declare @since datetime
	declare @price int

	declare estimation_elements cursor for
		SELECT est.estcode ,  prop.pcode , prop.padress , est.since, est.price
		from estimation est , properties prop , estimator
		WHERE since>=@date_Time1 and since<=@date_Time2 and prop.pcode=est.pcode and @ecode = estimator.ecode and estimator.ecode =est.ecode


open estimation_elements;
fetch next from estimation_elements into @estcode,@pcode,@padress,@since,@price;

while ( @@FETCH_STATUS=0)
	begin
		print 'EstCode: '+ @estcode 
		print 'Pcode: '+@pcode
		print 'Padress: '+@padress
		print 'Since: '+cast(@since as varchar(100))
		print 'Price: '+cast(@price as varchar(100))
		print(' ')

		fetch next from estimation_elements into @estcode,@pcode,@padress,@since,@price;
	end
close estimation_elements;
deallocate estimation_elements;
end

GO
execute find_ecode @ecode=12305 ,@date_Time1='2015-04-19' , @date_Time2='2020-07-19';
