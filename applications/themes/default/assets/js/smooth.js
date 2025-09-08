if (window.location.hash) {
    // Save the anchor
    const hash = window.location.hash;

    // Temporarily remove the anchor from the URL
    history.replaceState(null, null, window.location.pathname);

    // When the page is loaded
    window.addEventListener('load', function() {
        setTimeout(function() {
            // Put the anchor back in the URL
            history.replaceState(null, null, window.location.pathname + hash);

            // Enable smooth scroll
            document.documentElement.classList.add('smooth-scroll');

            // Perform the smooth scroll
            const target = document.querySelector(hash);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        }, 100);
    });
}