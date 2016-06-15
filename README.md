# Tittle Tattle

`Debug.crash`

## Sitemap

```elm
type Route
  = HomeRoute -- `/`
  | ServicesRoutes -- `/services`
      -- Always used, provides UI-nesting/children
      -- {services : List Service}
    = IndexRoute -- `/services/`
      -- Never children
    | ServiceRoutes String -- `/services/{username}`
        -- UI wrapping (sub-navigation)
        -- {service: Service}
      = IndexRoute -- `/services/{username}/`
        -- Show service + accesstoken
      | SendRoute  -- `/services/{username}/send`
        -- {service: Service ,groups: List Group}
      | BatchesRoutes  -- `/services/{username}/batches`
        = IndexRoute -- `/services/{username}/batches/`
          -- list batches
          -- {service: Service ,batches: List Batch}
        | BatchRoute String -- `/services/{username}/batches/{batch-id}`
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
