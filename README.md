# Tittle Tattle

`Debug.crash`

## Sitemap

### / -> HomeRoute (aliased /services ServicesIndexRoute)


 - List of services
 - Add form
 - No topnav

### /{username} -> ServiceRoutes ServiceIndexRoute

- Show service + access token
- Maybe edit

### /{username}/send -> ServiceRoutes SendRoute

- Show composer

### /{username}/history -> ServiceRoutes HistoryRoutes HistoryIndexRoute

- List sent batches

### /{username}/history/{id} -> ServiceRoutes HistoryRoutes BatchId

- Show individual batch

### /{username}/groups -> ServiceRoutes GroupsRoutes GroupsIndexRoute

- Groups etc.
- TBD


## TODO

- [ ] Fully specify sitemap

## Slum

```
.---------------------------------------------.
| #@  { username }  | v { tokens | add token} |
.---------------------------------------------.
| Send | Inbox | History | Schedule | Groups  |
.---------------------------------------------.
|                                             |
|                    <3                       |
|                                             |
'---------------------------------------------'
```
