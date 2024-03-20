# SQL

```SQL
SELECT c.id, c."userId", u.email, u."firstName", u."lastName",
c."preferredSquareCardId" FROM public.customer c LEFT JOIN public.user u ON
c."userId" = u.id WHERE c."merchantId" = 'PXJZRo5YhH97SLuzrtN1_' ORDER BY c.id
ASC;
```

```SQL
SELECT o."squareFulfillmentStatus", u."firstName", u."lastName", o."merchantId"
FROM public."order" o LEFT JOIN public.customer c ON o."customerId" = c."id"
LEFT JOIN public.user u ON u."id" = c."userId" ORDER BY o."customerId" ASC;
```
