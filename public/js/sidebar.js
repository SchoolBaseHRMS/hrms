document.addEventListener('DOMContentLoaded', function () {
    console.log('sidebar.js loaded');
    const nav = document.querySelector('.nav-links');
    const sidebar = document.getElementById('sidebar');
    const toggle = document.getElementById('sidebarToggle');
    const overlay = document.getElementById('sidebarOverlay');
    const toggleIcon = toggle ? toggle.querySelector('i') : null;

    if (!nav) return console.warn('nav-links not found');

    function setSidebarOpen(open) {
        if (!sidebar) return;
        const isOpen = !!open;
        sidebar.classList.toggle('open', isOpen);
        if (toggle) toggle.setAttribute('aria-expanded', String(isOpen));
        if (overlay) {
            overlay.setAttribute('aria-hidden', String(!isOpen));
            overlay.style.display = isOpen ? 'block' : 'none';
            overlay.style.opacity = isOpen ? '1' : '0';
        }
        
        if (toggle) toggle.style.display = isOpen ? 'none' : '';
       
    }

    window.addEventListener('resize', function () {
        if (window.innerWidth > 768 && sidebar) setSidebarOpen(false);
    });

    if (toggle) {
        toggle.addEventListener('click', function () {
            setSidebarOpen(!sidebar.classList.contains('open'));
        });
    }

    if (overlay) {
        overlay.addEventListener('click', function () { setSidebarOpen(false); });
        overlay.style.display = 'none';
        overlay.style.opacity = '0';
        overlay.style.transition = 'opacity 180ms ease';
    }

    nav.addEventListener('click', function (e) {
        const arrow = e.target.closest('.arrow');
        if (arrow) {
            e.preventDefault();
            const parentLi = arrow.closest('li');
            if (!parentLi) return;
            parentLi.classList.toggle('showMenu');
            return;
        }

        const link = e.target.closest('.icon-link > a, .nav-links > li > a, .nav-links li a');
        if (!link) return;
        const parentLi = link.closest('li');
        if (!parentLi) return;
        const submenu = parentLi.querySelector('.sub-menu');
        if (submenu) {
            e.preventDefault();
            parentLi.classList.toggle('showMenu');
            return;
        }
        nav.querySelectorAll('li').forEach(li => li.classList.remove('active'));
        parentLi.classList.add('active');
        if (window.innerWidth <= 768) setSidebarOpen(false);
    });

    nav.querySelectorAll('.arrow').forEach(a => {
        a.setAttribute('tabindex', '0');
        a.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); a.click(); }
        });
    });

    document.addEventListener('click', function (e) {
        if (!e.target.closest('.sidebar') && !e.target.closest('#sidebarToggle')) {
            nav.querySelectorAll('li.showMenu').forEach(li => li.classList.remove('showMenu'));
            if (window.innerWidth <= 768) setSidebarOpen(false);
        }
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') setSidebarOpen(false);
    });
    
});