DELETE FROM auth.menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'CineSys'
);

DELETE FROM auth.group_menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'CineSys'
);

DELETE FROM core.menus
WHERE app_name = 'CineSys';


SELECT * FROM core.create_app('CineSys', 'Cinema', '1.0', 'MixERP Inc.', 'December 1, 2015', 'teal film', '/dashboard/cinesys/home', NULL::text[]);

SELECT * FROM core.create_menu('CineSys', 'Tasks', '/dashboard/cinesys/home', 'lightning', '');
SELECT * FROM core.create_menu('CineSys', 'Home', '/dashboard/cinesys/home', 'user', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Ticketing', '/dashboard/cinesys/ticketing', 'ticket', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Food Court', '/dashboard/cinesys/foodcourt', 'food', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Counters', '/dashboard/cinesys/counters', 'keyboard', 'Tasks');
SELECT * FROM core.create_menu('CineSys', 'Cashiers', '/dashboard/cinesys/cashiers', 'users', 'Tasks');

SELECT * FROM core.create_menu('CineSys', 'Cinema', 'square outline', 'configure', '');
SELECT * FROM core.create_menu('CineSys', 'Screens', '/dashboard/cinesys/screens', 'desktop', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Movies', '/dashboard/cinesys/movies', 'film', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Cinemas', '/dashboard/cinesys/cinemas', 'square outline', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Shows', '/dashboard/cinesys/shows', 'clock', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Pricing Types', '/dashboard/cinesys/pricing-types', 'money', 'Cinema');
SELECT * FROM core.create_menu('CineSys', 'Pricings', '/dashboard/cinesys/pricings', 'money', 'Cinema');

SELECT * FROM core.create_menu('CineSys', 'Setup', '/dashboard/cinesys/setup', 'configure', '');
SELECT * FROM core.create_menu('CineSys', 'Genres', '/dashboard/cinesys/genres', 'lightning', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Film Formats', '/dashboard/cinesys/film-formats', 'film', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Ratings', '/dashboard/cinesys/ratings', 'star', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Categories', '/dashboard/cinesys/categories', 'sitemap', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Distributors', '/dashboard/cinesys/distributors', 'users', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Seat Types', '/dashboard/cinesys/seat-types', 'grid layout', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Arrangement', '/dashboard/cinesys/seating-arrangement', 'grid layout', 'Setup');
SELECT * FROM core.create_menu('CineSys', 'Shifts', '/dashboard/cinesys/shifts', 'clock', 'Setup');

SELECT * FROM core.create_menu('CineSys', 'Reports', '/dashboard/cinesys/setup', 'bar chart', '');
SELECT * FROM core.create_menu('CineSys', 'Sales by Cashier', '/dashboard/cinesys/reports/sales-by-cashier', 'money', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'Anusuchi 7', '/dashboard/cinesys/reports/anusuchi-7', 'money', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'Sales book', '/dashboard/cinesys/reports/sales-book', 'grid layout', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'User Audits', '/dashboard/cinesys/reports/user-audit', 'grid layout', 'Reports');
SELECT * FROM core.create_menu('CineSys', 'Cancelled Transactions', '/dashboard/cinesys/reports/cancelled-transactions', 'grid layout', 'Reports');

SELECT * FROM core.create_menu('CineSys', 'Help', '/dashboard/cinesys/help', 'help circle', '');
SELECT * FROM core.create_menu('CineSys', 'User Manual', '/Static/UserManual.pdf', 'star', 'Help');


SELECT * FROM auth.create_app_menu_policy
 (
    'Admin', 
    core.get_office_id_by_office_name('PCP'), 
    'Cinesys',
    '{*}'::text[]
);

