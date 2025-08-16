// Pure JS: enable submenu toggles and view switching for dashboard.php
document.addEventListener('DOMContentLoaded', function () {
  // submenu toggle buttons
  const toggles = Array.from(document.querySelectorAll('.toggle-sub'));
  toggles.forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      const id = btn.getAttribute('aria-controls');
      const submenu = id ? document.getElementById(id) : null;
      const isOpen = btn.getAttribute('aria-expanded') === 'true';

      // close other submenus (optional)
      toggles.forEach(other => {
        if (other !== btn) {
          const otherId = other.getAttribute('aria-controls');
          const otherSub = otherId ? document.getElementById(otherId) : null;
          other.setAttribute('aria-expanded', 'false');
          if (otherSub) otherSub.hidden = true;
          other.parentElement.classList.remove('active');
          const chev = other.querySelector('.chev');
          if (chev) chev.style.transform = '';
        }
      });

      // toggle this submenu
      btn.setAttribute('aria-expanded', String(!isOpen));
      if (submenu) submenu.hidden = isOpen;
      btn.parentElement.classList.toggle('active', !isOpen);

      const chev = btn.querySelector('.chev');
      if (chev) chev.style.transform = !isOpen ? 'rotate(90deg)' : '';
    });

    // keyboard support
    btn.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        btn.click();
      }
    });
  });

  // view switching: elements with data-view -> show #view-{name}
  function showView(name) {
    const all = document.querySelectorAll('.view');
    all.forEach(v => v.classList.remove('active'));
    const target = document.getElementById('view-' + name);
    if (target) target.classList.add('active');
    // update active link styles
    document.querySelectorAll('.menu-item, .submenu-item, .btn[data-view]').forEach(el => {
      el.classList.toggle('active', el.dataset.view === name);
    });
  }

  // hook menu links and submenu items
  document.body.addEventListener('click', function (e) {
    const a = e.target.closest('[data-view]');
    if (!a) return;
    e.preventDefault();
    const view = a.dataset.view;
    if (!view) return;
    showView(view);
  });

  // optional: show overview on load if no active view
  if (!document.querySelector('.view.active')) {
    showView('overview');
  }

});
