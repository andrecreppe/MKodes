clear all; close all;
clc

% Define the size of the 3D grid
Nx = 30;
Ny = 30;
Nz = 30;

% Constantes
Lx = 83e-3; % Comprimento na direção x (metros)
Ly = 68e-3; % Comprimento na direção y (metros)
Lz = 10e-3; % Comprimento na direção z (metros)

dx = Lx / (Nx - 1); % Espaçamento na direção x
dy = Ly / (Ny - 1); % Espaçamento na direção y
dz = Lz / (Nz - 1); % Espaçamento na direção z

Tinf = 25; % Temperatura ambiente (Celsius)
h = 24; % Coeficiente de transferência de calor por convecção (W/m^2.K)
keq = 180; % Condutividade térmica (W/m.K)
k=keq;
q_prime = 78000 ; % Geração interna de calor (W/m^2)
geracao_calor = q_prime / Lz; % Geração interna de calor volumétrica (W/m^3)

% Inicializa o campo de temperatura
T_old = Tinf * ones(Nx, Ny, Nz);
T = Tinf * ones(Nx, Ny, Nz);

% Definição da região de geração interna de calor (31x31 mm²) na base
hx = round(31e-3 / dx/2); % Meia largura da zona de calor em termos de nós
hy = round(31e-3 / dy/2); % Meia altura da zona de calor em termos de nós

% Índices da região de geração de calor na base
zona_calor_x = (round(Nx/2) - hx):(round(Nx/2) + hx);
zona_calor_y = (round(Ny/2) - hy):(round(Ny/2) + hy);

% Iterate over each point in the 3D grid
for iter = 1:1000
    T_old = T;
    for i = 2:Nx-1
        for j = 2:Ny-1
            for k = 2:Nz-1
                if k == 2 || k == Nz-1
                    % Point on the face z = 2 or z = Nz-1
                    if k == 2 && any(i == zona_calor_x) && any(j == zona_calor_y)
                        q_vol = geracao_calor;
                        T(i, j, k) = (1 / (dy*(dz/dx) + dx*(dz/dy) + (dx*dy)/dz)) * ...
                             ((dx*dz/(2*dy))*(T_old(i, j-1, k) + T_old(i, j+1, k)) + ...
                              (dy*dz/(2*dx))*(T_old(i-1, j, k) + T_old(i+1, j, k)) + ...
                              (dx*dy/dz)*(T_old(i, j, k+1)) + ...
                              q_prime*dx*dy/(k));
                    else
                        q_vol=0;
                        if k == 2
                             T(i, j, k) = (1 / (dy*dz/dx + dx*dz/dy+ dx*dy/dz + h*dx*dy/k)) * ...
                             ((dx*dz/(2*dy))*(T_old(i, j-1, k) + T_old(i, j+1, k)) + ...
                              (dy*dz/(2*dx))*(T_old(i-1, j, k) + T_old(i+1, j, k)) + ...
                              (dx*dy/dz)*(T_old(i, j, k+1)) + ...
                              h*dx*dz*Tinf/keq + q_vol*dx*dy*dz/(2*k));
                        
                        else
                        % Apply boundary condition for z = Nz-1
                        %q_vol=0;
                            
                            T(i, j, k) = (1 / (dy*dz/dx + dx*dz/dy+ dx*dy/dz + h*dx*dy/k)) * ...
                             ((dx*dz/(2*dy))*(T_old(i, j-1, k) + T_old(i, j+1, k)) + ...
                              (dy*dz/(2*dx))*(T_old(i-1, j, k) + T_old(i+1, j, k)) + ...
                              (dx*dy/dz)*(T_old(i, j, k-1)) + ...
                              h*dx*dz*Tinf/keq + q_vol*dx*dy*dz/(2*k));
                        end
                    end
                    
                elseif j == 2 || j == Ny-1
                    q_vol=0;
                    % Point on the face y = 2 or y = Ny-1
                    if j == 2
                        % Apply boundary condition for y = 2
                        
                        T(i, j, k) = (1 / (dy*dz/dx + dx*dz/dy+ dx*dy/dz + h*dx*dz/k)) * ...
                             ((dx*dy/(2*dz))*(T_old(i, j, k-1) + T_old(i, j, k+1)) + ...
                              (dy*dz/(2*dx))*(T_old(i-1, j, k) + T_old(i+1, j, k)) + ...
                              (dx*dz/dy)*(T_old(i, j+1, k)) + ...
                              h*dx*dz*Tinf/keq + q_vol*dx*dy*dz/(2*k));
                    else
                        % Apply boundary condition for y = Ny-1
                        
                        T(i, j, k) = (1 / (dy*dz/dx + dx*dz/dy+ dx*dy/dz + h*dx*dz/k)) * ...
                             ((dx*dy/(2*dz))*(T_old(i, j, k-1) + T_old(i, j, k+1)) + ...
                              (dy*dz/(2*dx))*(T_old(i-1, j, k) + T_old(i+1, j, k)) + ...
                              (dx*dz/dy)*(T_old(i, j-1, k)) + ...
                              h*dx*dz*Tinf/keq + q_vol*dx*dy*dz/(2*k));
                    end
                elseif i == 2 || i == Nx-1
                    q_vol=0;
                    % Point on the face x = 2 or x = Nx-1
                    if i == 2
                        % Apply boundary condition for x = 2
                         
                         T(i, j, k) = (1 / (dy*dz/dx + dx*dz/dy+ dx*dy/dz + h*dy*dz/k)) * ...
                             ((dx*dy/(2*dz))*(T_old(i, j, k-1) + T_old(i, j, k+1)) + ...
                              (dx*dz/(2*dy))*(T_old(i, j+1, k) + T_old(i, j-1, k)) + ...
                              (dy*dz/dx)*(T_old(i+1, j, k)) + ...
                              h*dy*dz*Tinf/keq + q_vol*dx*dy*dz/(2*k));
                    else
                        
                        T(i, j, k) = (1 / (dy*dz/dx + dx*dz/dy+ dx*dy/dz + h*dy*dz/k)) * ...
                             ((dx*dy/(2*dz))*(T_old(i, j, k-1) + T_old(i, j, k+1)) + ...
                              (dx*dz/(2*dy))*(T_old(i, j+1, k) + T_old(i, j-1, k)) + ...
                              (dy*dz/dx)*(T_old(i-1, j, k)) + ...
                              h*dy*dz*Tinf/keq + q_vol*dx*dy*dz/(2*k));
                    end
                else
                    q_vol=0;
                    % Internal point
                    % Apply the finite difference equation for internal points
                     T(i, j, k) = (1 / (2*dy*dz/dx + 2*dx*dz/dy+ 2*dx*dy/dz)) * ...
                             ((dy*dz/dx)*(T_old(i+1, j, k) + T_old(i-1, j, k)) + ...
                              (dx*dz/dy)*(T_old(i, j+1, k) + T_old(i, j-1, k)) + ...
                              (dx*dy/dz)*(T_old(i, j, k+1) + T_old(i, j, k-1)) + ...
                              q_vol*dx*dy*dz/keq);

                end
            end
        end

    end        
    if max(max(max(abs(T - T_old)))) < 1e-6
        break;
    end
end


% Visualiza a distribuição de temperatura
[x, y, z] = meshgrid(linspace(0, Lx, Nx), linspace(0, Ly, Ny), linspace(0, Lz, Nz));
figure(1);
    slice(x, y, z, T, [], [], dz);
    hold on;
    slice(x, y, z, T, [], [], Lz-dz);
    slice(x, y, z, T, Lx/2, Ly/2,dz, Lx/3);
    shading interp;  % Interpolate colors for a smoother appearance
    colorbar;  % Display a colorbar to show the temperature scale
    colormap jet;  % Use the 'jet' colormap for better visualization
    xlabel('X (m)');    xlim([dx Lx-dx]);
    ylabel('Y (m)');    ylim([dy Ly-dy]);
    zlabel('Z (m)');    zlim([dz Lz-dz]);
    title('Distribuição de Temperatura');

figure(2);
    scatter3(x(:), y(:), z(:), 50, T(:), 'filled');
    colormap jet;
    colorbar;
    shading interp;
    xlabel('X (m)');    xlim([dx Lx-dx]);
    ylabel('Y (m)');    ylim([dy Ly-dy]);
    zlabel('Z (m)');    zlim([dz Lz-dz]);
    title('Distribuição de Temperatura');

figure(3);
    slice(x, y, z, T, Lx, Ly, Lz);
    hold on;
    for n=1:30
        slice(x, y, z, T, n*Lx/30, n*Ly/30, n*Lz/30);
    end
    colormap jet;
    colorbar;
    shading interp;
    xlabel('X (m)');        ylabel('Y (m)');    zlabel('Z (m)');
    xlim([dx Lx-dx]);       ylim([dy Ly-dy]);   zlim([dz Lz-dz]);
    title('Distribuição de Temperatura');