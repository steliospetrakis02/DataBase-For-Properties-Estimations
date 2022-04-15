use db122;
drop procedure find_sub_area;

GO
CREATE procedure find_sub_area
(

@acode CHAR(10) 

)
as
BEGIN

SET NOCOUNT ON;

SELECT acode , aname 
from area
WHERE wregioncode = @acode
END


GO 
EXEC test @acode =00011 ;
GO
