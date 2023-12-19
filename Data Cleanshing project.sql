use [Nashvile Housing]

select * from [dbo].[Housing]


-- Standardize date form 
select SaleDate, CONVERT(DATE, SaleDate)
from [dbo].[Housing]

Update [dbo].[Housing]
SET SaleDate = CONVERT(DATE, SaleDate)

-- If doesn't work 

ALTER TABLE [dbo].[Housing]
Add SaleDateConvert Date

Update [dbo].[Housing]
SET SaleDateConvert = CONVERT(DATE, SaleDate)


-- Populate properly address

select * 
from [dbo].[Housing]
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL (a.PropertyAddress, b.PropertyAddress)
from [dbo].[Housing] a
JOIN [dbo].[Housing] b
on a.ParcelID=b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
SET PropertyAddress= ISNULL (a.PropertyAddress, b.PropertyAddress)
from [dbo].[Housing] a
JOIN [dbo].[Housing] b
on a.ParcelID=b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


-- Separated city and address 
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
from [dbo].[Housing]

ALTER TABLE [dbo].[Housing]
Add PropertySplitAddres Nvarchar(225)

Update [dbo].[Housing]
set PropertySplitAddres = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE [dbo].[Housing]
Add PropertySplitCity Nvarchar(225)

Update [dbo].[Housing]
set PropertySplitCity=SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




-- 
Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [dbo].[Housing]


ALTER TABLE [dbo].[Housing]
Add OwnerSplitAddress Nvarchar(255);

Update [dbo].[Housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE [dbo].[Housing]
Add OwnerSplitCity Nvarchar(255);

Update [dbo].[Housing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [dbo].[Housing]
Add OwnerSplitState Nvarchar(255);

Update [dbo].[Housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)




-- Change Y and N to Yes and No in "Sold as Vacant" field
select SoldAsVacant 
	,case when SoldAsVacant='Y' THEN 'Yes'
		  when SoldAsVacant='N' THEN 'No'
		  ELSE SoldAsVacant
		  END
from [dbo].[Housing]


update [dbo].[Housing]
SET SoldAsVacant = case when SoldAsVacant='Y' THEN 'Yes'
		  when SoldAsVacant='N' THEN 'No'
		  ELSE SoldAsVacant
		  END