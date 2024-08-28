% Tham số ban đầu
X = 50;       % Số điểm lưới theo chiều X
Y = 50;       % Số điểm lưới theo chiều Y
D = 0.01;     % Hệ số khuếch tán nhiệt
dx = 0.01;    % Kích thước bước lưới không gian
dt = 0.001;   % Kích thước bước thời gian
T = 0.5;      % Thời gian mô phỏng
t0 = 0;       % Thời gian bắt đầu
X_toanhiet = 5;  % Kích thước nguồn nhiệt theo chiều X
Y_toanhiet = 5;  % Kích thước nguồn nhiệt theo chiều Y

% Khởi tạo giá trị ban đầu
C = 25 * ones(X, Y);  
figure;
imagesc(C);
colorbar;
title('Phân bố nhiệt độ ban đầu');
pause(10);

figure;
% Mô phỏng quá trình truyền nhiệt
% Buoc 1: Tính đạo hàm bậc 2 của nhiệt độ theo không gian
t = t0;
while t < T
    for i = 1:X
        for j = 1:Y
            % Kiểm tra điều kiện biên
            if i == 1
                u = 25;
            else
                u = C(i-1, j);
            end

            if j == 1
                l = 25;
            else
                l = C(i, j-1);
            end

            if i == X
                d = 25;
            else
                d = C(i+1, j);
            end

            if j == Y
                r = 25;
            else
                r = C(i, j+1);
            end

            c = C(i, j);  % Nhiệt độ điểm đang khảo sát
            deltaC2(i, j) = (d + u + r + l - 4 * c) / (dx * dx);   
        end
    end

    % Bước 2: Tính đạo hàm theo thời gian
    a = X / 2 - X_toanhiet / 2;
    b = X / 2 + X_toanhiet / 2;
    e = Y / 2 - Y_toanhiet / 2;
    f = Y / 2 + Y_toanhiet / 2;
    
    for i = 1:X
        for j = 1:Y
            if i >= a && i <= b && j >= e && j <= f
                Ct(i, j) = 80;
            else
                Ct(i, j) = C(i, j) + dt * D * deltaC2(i, j);
            end
        end
    end
    
    % Cập nhật lại theo thời gian
    for i = 1:X
        for j = 1:Y
            C(i, j) = Ct(i, j);
        end
    end
    
    t = t + dt;
    
    % Mô phỏng
    x = 1:X;
    y = 1:Y;
    [Xgrid, Ygrid] = meshgrid(x, y);
    surf(Xgrid, Ygrid, C);
    colorbar;
    title(['Phân bố nhiệt độ tại thời điểm t = ', num2str(t)]);
    xlabel('X');
    ylabel('Y');
    zlabel('Nhiệt độ');
    pause(0.1);
end

% Hiển thị phân bố nhiệt độ cuối cùng
figure;
surf(Xgrid, Ygrid, C);
colorbar;
title('Phân bố nhiệt độ cuối cùng');
xlabel('X');
ylabel('Y');
zlabel('Nhiệt độ');

% Thêm hình ảnh 2D của phân bố nhiệt độ cuối cùng
figure;
imagesc(C);
colorbar;
title('Ảnh 2D của phân bố nhiệt độ cuối cùng');
xlabel('X');
ylabel('Y');
