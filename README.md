# Tittle Tattle

`Debug.crash`

## Sitemap

```elm
type Route
  = Home -- `/`
  | Services -- `/services`
      -- Always used, provides UI-nesting/children
      -- {services : List Service}
    = Index -- `/services/`
      -- Never children
    | Service String -- `/services/{username}`
        -- UI wrapping (sub-navigation)
        -- {service: Service}
      = Index -- `/services/{username}/`
        -- Show service + accesstoken
      | Send  -- `/services/{username}/send`
        -- {service: Service ,groups: List Group}
      | Batches  -- `/services/{username}/batches`
        = Index -- `/services/{username}/batches/`
          -- list batches
          -- {service: Service ,batches: List Batch}
        | Batch String -- `/services/{username}/batches/{batch-id}`
```

## TODO

- [ ] Fully specify sitemap
- [ ] Compare componate data passing to Redux's `connect(mapStateToProps,...)`

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
