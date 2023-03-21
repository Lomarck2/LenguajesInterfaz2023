#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <stdlib.h>

const double xmax=400, ymax = 400;
void cuadrado(float cx, float cy,float lado);

static void display(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    cuadrado(0,0,100);

    glutSwapBuffers();
}


static void key(unsigned char key, int x, int y)
{
    switch (key)
    {
        case 27 :
        case 'q':
            exit(0);
            break;

        case '+':
            break;

        case '-':
            break;
    }

    glutPostRedisplay();
}

int main(int argc, char *argv[])
{
    glutInit(&argc, argv);
    glutInitWindowSize(800,800);
    glutInitWindowPosition(10,10);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);

    glutCreateWindow("Arbol de Pitagoras");

    glutDisplayFunc(display);
    glutKeyboardFunc(key);

    glOrtho(-xmax,xmax,-ymax,ymax,1,-1);
    glutMainLoop();

    return EXIT_SUCCESS;
}

void cuadrado(float cx, float cy,float l)
{
    float v1x, v1y, v2x, v2y, v3x, v3y, v4x, v4y;
    v1x = cx - (l/2.0f);
    v1y = cy - (l/2.0f);
    v2x = cx + (l/2.0f);
    v2y = cy - (l/2.0f);
    v3x = cx + (l/2.0f);
    v3y = cx + (l/2.0f);
    v4x = cx - (l/2.0f);
    v4y = cx + (l/2.0f);
    glBegin(GL_QUADS);
        glColor3f(0.0f,0.0f,1.0f);
        glVertex2f(v1x,v1y);
        glVertex2f(v2x,v2y);
        glVertex2f(v3x,v3y);
        glVertex2f(v4x,v4y);
    glEnd();
}
