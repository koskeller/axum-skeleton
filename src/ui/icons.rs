use leptos::*;
use tailwind_fuse::*;

#[component]
pub fn IconChevronLeft(#[prop(optional, into)] class: String) -> impl IntoView {
    let class = tw_merge!("lucide lucide-chevron-left", class);
    view! {
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class=class><path d="m15 18-6-6 6-6"/></svg>
    }
}

#[component]
pub fn IconChevronRight(#[prop(optional, into)] class: String) -> impl IntoView {
    let class = tw_merge!("lucide lucide-chevron-right", class);
    view! {
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class=class><path d="m9 18 6-6-6-6"/></svg>
    }
}

#[component]
pub fn IconEllipsis(#[prop(optional, into)] class: String) -> impl IntoView {
    let class = tw_merge!("lucide lucide-ellipsis", class);
    view! {
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class=class><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/><circle cx="5" cy="12" r="1"/></svg>
    }
}