import { TestBed } from '@angular/core/testing';
import { MenuService, Menu } from './menu.service';

describe('MenuService', () => {
  let service: MenuService;

  const dummyMenu: Menu[] = [
    {
      route: 'dashboard',
      name: 'Dashboard',
      type: 'link',
      icon: 'home',
      children: [
        {
          route: 'ventas',
          name: 'Ventas',
          type: 'link',
        },
      ],
    },
  ];

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MenuService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should return menu after set()', (done) => {
    service.set(dummyMenu);
    service.getAll().subscribe((menu) => {
      expect(menu).toEqual(dummyMenu);
      done();
    });
  });

  it('should add new menu item', (done) => {
    service.set([]);
    const newItem: Menu = {
      route: 'reportes',
      name: 'Reportes',
      type: 'link',
      icon: 'bar_chart',
    };
    service.add(newItem);
    service.getAll().subscribe((menu) => {
      expect(menu.length).toBe(1);
      expect(menu[0].name).toBe('Reportes');
      done();
    });
  });

  it('should reset menu', (done) => {
    service.set(dummyMenu);
    service.reset();
    service.getAll().subscribe((menu) => {
      expect(menu).toEqual([]);
      done();
    });
  });

  it('should build route correctly', () => {
    const route = service.buildRoute(['', '/ventas/', '/mensuales/']);
    expect(route).toBe('/ventas/mensuales');
  });

  it('should get item name from route', () => {
    service.set(dummyMenu);
    const name = service.getItemName(['dashboard', 'ventas']);
    expect(name).toBe('Ventas');
  });

  it('should add namespace recursively', () => {
    const menus: Menu[] = JSON.parse(JSON.stringify(dummyMenu)); // clonar
    service.addNamespace(menus, 'main');
    expect(menus[0].name).toBe('main.Dashboard');
    expect(menus[0].children?.[0].name).toBe('main.Dashboard.Ventas');
  });
});
