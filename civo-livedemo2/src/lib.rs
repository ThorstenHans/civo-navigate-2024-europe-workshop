use spin_sdk::http::{IntoResponse, Params, Request, Response, ResponseBuilder, Router};
use spin_sdk::http_component;
use spin_sdk::key_value::Store;
/// A simple Spin HTTP component.
#[http_component]
fn handle_civo_livedemo(req: Request) -> anyhow::Result<impl IntoResponse> {
    let mut r = Router::default();
    r.get("/:key", handle_get);
    r.post("/:key", handle_set);
    Ok(r.handle(req))
}

fn handle_set(req: Request, params: Params) -> anyhow::Result<impl IntoResponse> {
    let key = params.get("key").unwrap();
    let store = Store::open_default()?;
    store.set(key, req.body())?;
    Ok(Response::builder()
        .status(201)
        .header("Location", format!("/{}", key))
        .body(())
        .build())
}

fn handle_get(_req: Request, params: Params) -> anyhow::Result<impl IntoResponse> {
    let key = params.get("key").unwrap();
    let store = Store::open_default()?;
    Ok(match store.get(key)? {
        Some(value) => ResponseBuilder::new(200)
            .header("Content-Type", "text/plain")
            .body(value)
            .build(),
        None => ResponseBuilder::new(404).body(()).build(),
    })
}
